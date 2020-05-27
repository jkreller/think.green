//
//  HideableCard.swift
//  think.green
//
//  Created by Julian Kreller on 28.02.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct InteractiveCard: View {
    // Constants
    static let cardHeaderHeight: CGFloat = 108
    let cardAnimationDuration: Double = 0.3
    
    var title: String
    var content: String
    var yOffset: CGFloat
    // If is set to one, card is in background; if is set to 0 card is in foreground
    @Binding var inBackgroundFactor: CGFloat
    @Binding var cardHeight: CGFloat
    @Binding var zIndex: Double?
    
    // Value of reveal factor is always between 0 and 1
    // the value is 0 when card is hidden and 1 when card is revealed.
    // Changes by drag (see getDrag function)
    @Binding var revealFactor: CGFloat
    
    init(
        title: String,
        content: String,
        yOffset: CGFloat,
        inBackgroundFactor: Binding<CGFloat> = .constant(0),
        cardHeight: Binding<CGFloat>,
        zIndex: Binding<Double?> = .constant(nil),
        revealFactor: Binding<CGFloat>
    ) {
        self.title = title
        self.content = content
        self.yOffset = yOffset
        self._inBackgroundFactor = inBackgroundFactor
        self._cardHeight = cardHeight
        self._zIndex = zIndex
        self._revealFactor = revealFactor
    }
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                // Only allow tap if card is not in background
                if (self.inBackgroundFactor == 0) {
                    //self.isRevealed.toggle()
                    self.revealFactor = self.revealFactor == 0 ? 1 : 0
                    self.setZIndex(delayed: true)
                }
        }
    }
    
    func getDrag(cardRevealedYPosition: CGFloat) -> some Gesture {
        // Only allow drag if card is not in background
        if (self.inBackgroundFactor == 0) {
            return DragGesture(coordinateSpace: .global)
            .onChanged { value in
                // Normalize drag translation height according to cards y-offset: 0 -> drag start; 1 -> card is revealed; -1 -> card is hidden
                let normalizedTranslationHeight = -(value.translation.height / self.yOffset)

                if (normalizedTranslationHeight > 0 && self.revealFactor < 1) {
                    // If direction of drag is upwards and card is hidden
                    self.revealFactor = normalizedTranslationHeight
                } else if (normalizedTranslationHeight < 0 && self.revealFactor > 0) {
                    // If direction of drag is downwards and card is revealed
                    self.revealFactor = 1 + normalizedTranslationHeight
                }
                
                // When card is being dragged it should always be on top
                self.zIndex = 1
                print(self.inBackgroundFactor)
            }
            .onEnded { value in
                let cardHiddenYPosition = cardRevealedYPosition + self.yOffset
                
                if (self.revealFactor < 1 && value.predictedEndLocation.y <= cardRevealedYPosition) {
                    // If card would be dragged farther then relvealed position then reveal
                    self.revealFactor = 1
                } else if (value.predictedEndLocation.y >= cardHiddenYPosition) {
                    // If card would be dragged farther then hidden position then hide
                    self.revealFactor = 0
                }
                
                // Reset reveal factor to hidden or revealed
                self.revealFactor = self.revealFactor < 1 ? 0 : 1
                
                self.setZIndex()
            }
        }
        
        return DragGesture()
            .onChanged {_ in }
            .onEnded {_ in }
    }
    
    // Set z-index according to reveal-status
    // Optional: setting to 0 can be delayed by cardAnimationDuration seconds
    func setZIndex(delayed: Bool = false) {
        if (self.revealFactor == 1) {
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
            // Set scale to 0.9 when in background
            .scaleEffect(1 - self.inBackgroundFactor * 0.1, anchor: .top) // backgroundFactor = 0 -> 1; backgroundFactor = 1 -> 0.9
            // Set opacity to 0.8 when in background
            .opacity(1 - Double(self.inBackgroundFactor) * 0.2)
            // Set pading to -25 when in background
            .padding(.top, self.inBackgroundFactor * -25)
            .padding([.leading, .trailing])
            .background(GeometryReader { geometry in
                Color.clear.onAppear {
                    self.cardHeight = geometry.size.height
                }
            })
            // Set offset according to reveal status
            .offset(y: self.yOffset * (1 - self.revealFactor))
            .animation((self.zIndex != nil) ? .easeOut(duration: self.cardAnimationDuration) : .easeOut)
            .gesture(self.tap)
            .gesture(self.getDrag(cardRevealedYPosition: geometry.frame(in: .global).origin.y))
        }
            // Set card height according to dragFactor
            .frame(height: self.cardHeight * self.revealFactor)
            // Set offset to show up in screen if card is hidden and to set this offset to half if revealed
            .offset(y: InteractiveCard.cardHeaderHeight * (-0.5 * self.revealFactor + self.revealFactor - 1))
    }
}

struct InteractiveCardView_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtDetail(thought: thoughtData[2])
    }
}
