//
//  ThoughtDetail.swift
//  think.green
//
//  Created by Julian Kreller on 09.01.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ThoughtDetail: View {
    @State var tappedWhatCard: Bool = false
    @State var tappedWhyCard: Bool = false
    @State var zIndexWhyCard: Double = 0
    @State var whatCardHeight: CGFloat = 0
    @State var whyCardHeight: CGFloat = 0
    @State var titleHeight: CGFloat = 0
    let cardAnimationDuration: Double = 0.3
    let thought: Thought
    var cardHeightDifference: CGFloat { (self.whatCardHeight - self.whyCardHeight) / 2 }
    var halfCardHeight: CGFloat { self.whatCardHeight / 2 }
    
    func setZIndexDelayed() {
        if (self.tappedWhyCard) {
            self.zIndexWhyCard = 1
        } else {
            // Delay setting of zIndex by cardAnimationDuration to avoid wrong overlay order when moving cards
            DispatchQueue.main.asyncAfter(deadline: .now() + self.cardAnimationDuration) {
                self.zIndexWhyCard = 0
            }
        }
    }
    
    var body: some View {
        BaseView {
            GeometryReader { geometry in
                VStack {
                    ThoughtTitle(image: self.thought.image, title: self.thought.title, titleHeight: self.$titleHeight)
                        .scaleEffect(self.tappedWhatCard ? 0.8 : 1, anchor: .bottom)
                        .animation(.easeOut)
                    
                    ZStack {
                        InteractiveCard(
                            title: "Why?",
                            content: self.thought.reason,
                            yOffset: self.calculateCardOffset(cardHeight: self.whyCardHeight, screenHeight: geometry.size.height),
                            cardHeight: self.$whyCardHeight,
                            tapped: self.$tappedWhyCard,
                            animationDuration: self.cardAnimationDuration,
                            onTap: self.setZIndexDelayed
                        )
                            .zIndex(self.zIndexWhyCard)
                        
                        InteractiveCard(
                            title: "What?",
                            content: self.thought.description,
                            yOffset: self.calculateCardOffset(cardHeight: self.whatCardHeight, screenHeight: geometry.size.height),
                            inBackground: self.tappedWhyCard,
                            cardHeight: self.$whatCardHeight,
                            tapped: self.$tappedWhatCard,
                            animationDuration: self.cardAnimationDuration
                        )
                    }
                }
            }
        }
    }
    
    func calculateCardOffset(cardHeight: CGFloat, screenHeight: CGFloat) -> CGFloat {
        print("Screenheight: \(screenHeight)")
        print("UIScreen: \(UIScreen.main.bounds.height)")
        
        var usedScreenHeight: CGFloat = screenHeight
        if (UIDevice.current.hasNotch) {
            usedScreenHeight = UIScreen.main.bounds.height
        }
        
        // Calculate card y-offset by card height plus half of left space on screen minus fix value (card header)
        return cardHeight + (usedScreenHeight - cardHeight - self.titleHeight) / 2 - 116
    }
}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

struct ThoughtDetail_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 11"], id: \.self) { deviceName in
            ThoughtDetail(thought: thoughtData[1])
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
