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
    var animationDuration: Double? = nil
    var onTap: (() -> Void)? = nil
    
    @Binding var dragFactor: CGFloat
    @State var dragYOffset: CGFloat = 0
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                if (!self.inBackground) {
                    self.isRevealed.toggle()
                }
                
                if (self.onTap != nil) {
                    self.onTap!()
                }
        }
    }
    
    func getDrag(cardRevealedYPosition: CGFloat) -> some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { value in
                self.dragYOffset = value.translation.height
                self.dragFactor = -(self.dragYOffset / self.yOffset)
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
                
                self.dragYOffset = 0
                self.dragFactor = 0
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
            .animation((self.animationDuration != nil) ? .easeOut(duration: self.animationDuration!) : .easeOut)
            .gesture(self.tap)
            .gesture(self.getDrag(cardRevealedYPosition: geometry.frame(in: .global).origin.y))
        }
            .frame(height: self.isRevealed ? self.cardHeight : 0)
    }
}

struct InteractiveCardView_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtDetail(thought: thoughtData[4])
    }
}
