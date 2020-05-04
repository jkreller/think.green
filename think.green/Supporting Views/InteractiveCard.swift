//
//  HideableCard.swift
//  think.green
//
//  Created by Julian Kreller on 28.02.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct InteractiveCard: View {
    var title: String
    var content: String
    var yOffset: CGFloat
    var inBackground: Bool = false
    @Binding var cardHeight: CGFloat
    @Binding var isRevealed: Bool
    @Binding var zIndex: Double?
    
    // Drag variables
    @Binding var dragFactor: CGFloat
    @State private var dragYOffset: CGFloat = 0
    
    init(
        title: String,
        content: String,
        yOffset: CGFloat,
        inBackground: Bool = false,
        cardHeight: Binding<CGFloat>,
        isRevealed: Binding<Bool>,
        zIndex: Binding<Double?> = .constant(nil),
        dragFactor: Binding<CGFloat>
    ) {
        self.title = title
        self.content = content
        self.yOffset = yOffset
        self.inBackground = inBackground
        self._cardHeight = cardHeight
        self._isRevealed = isRevealed
        self._zIndex = zIndex
        self._dragFactor = dragFactor
    }
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                if (!self.inBackground) {
                    self.isRevealed.toggle()
                }
                
                self.setZIndex(delayed: true)
        }
    }
    
    // Constants
    let cardAnimationDuration: Double = 0.3
    
    func getDrag(cardRevealedYPosition: CGFloat) -> some Gesture {
        return DragGesture(coordinateSpace: .global)
            .onChanged { value in
                self.dragYOffset = value.translation.height
                self.dragFactor = -(self.dragYOffset / self.yOffset)
                
                // When card is being dragged it should always be on top
                self.zIndex = 1
            }
            .onEnded { value in
                let cardHiddenYPosition = cardRevealedYPosition + self.yOffset
                
                if (!self.isRevealed && value.predictedEndLocation.y <= cardRevealedYPosition) {
                    // If card would be dragged farther then relvealed position then reveal
                    self.isRevealed = true
                } else if (value.predictedEndLocation.y >= cardHiddenYPosition) {
                    // If card would be dragged farther then hidden position then hide
                    self.isRevealed = false
                }
                
                // Reset variables
                self.dragYOffset = 0
                self.dragFactor = 0
                
                self.setZIndex()
            }
    }
    
    // Set z-index according to reveal-status
    // Optional: setting to 0 can be delayed by cardAnimationDuration seconds
    func setZIndex(delayed: Bool = false) {
        if (self.isRevealed) {
            self.zIndex = 1
        } else if (delayed) {
            // Delay setting of zIndex by cardAnimationDuration to avoid wrong overlay order when moving cards
            DispatchQueue.main.asyncAfter(deadline: .now() + self.cardAnimationDuration) {
                self.zIndex = 0
            }
        } else {
            self.zIndex = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            Card(title: self.title, content: self.content)
            .scaleEffect(self.inBackground ? 0.9 : 1, anchor: .top)
            .opacity(self.inBackground ? 0.8 : 1)
            .padding(.top, self.inBackground ? -25 : 0)
            .padding([.leading, .trailing])
            .background(GeometryReader { geometry in
                Color.clear.onAppear {
                    self.cardHeight = geometry.size.height
                }
            })
            // Add y-offset (move to bottom) if not revealed
            .offset(y: self.dragYOffset + (self.isRevealed ? 0 : self.yOffset))
            .animation((self.zIndex != nil) ? .easeOut(duration: self.cardAnimationDuration) : .easeOut)
            .gesture(self.tap)
            .gesture(self.getDrag(cardRevealedYPosition: geometry.frame(in: .global).origin.y))
        }
            .frame(height: self.isRevealed ? self.cardHeight : 0)
    }
}

struct InteractiveCardView_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtDetail(thought: thoughtData[2])
    }
}
