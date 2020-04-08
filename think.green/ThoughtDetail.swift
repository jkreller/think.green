//
//  ThoughtDetail.swift
//  think.green
//
//  Created by Julian Kreller on 09.01.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ThoughtDetail: View {
    // Init properties
    let thought: Thought
    
    // State properties
    @State var tappedWhatCard: Bool = false
    @State var tappedWhyCard: Bool = false
    @State var zIndexWhyCard: Double = 0
    @State var whatCardHeight: CGFloat = 0
    @State var whyCardHeight: CGFloat = 0
    @State var titleHeight: CGFloat = 0
    
    // Environment variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Constants
    let cardAnimationDuration: Double = 0.3
    let cardHeaderHeight: CGFloat = 108
    
    var backButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .modifier(SymbolTextStyle())
        }
    }
    
    var body: some View {
        NavigationView {
            BaseView {
                GeometryReader { geometry in
                    VStack {
                        ThoughtTitle(image: self.thought.image, title: self.thought.title, titleHeight: self.$titleHeight)
                            .scaleEffect(self.tappedWhatCard ? 0.8 : 1, anchor: .bottom)
                            .animation(.easeOut)
                            .padding(.top, 20)
                            // Set offset when card tapped to move to top, otherwise stay in middle
                            .offset(y: self.tappedWhatCard ? -self.cardHeaderHeight : -self.cardHeaderHeight * 0.5)
                        
                        ZStack {
                            InteractiveCard(
                                title: "Why?",
                                content: self.thought.reason,
                                yOffset: self.calculateCardOffset(cardHeight: self.whyCardHeight, availableSpace: geometry.size.height),
                                cardHeight: self.$whyCardHeight,
                                tapped: self.$tappedWhyCard,
                                animationDuration: self.cardAnimationDuration,
                                onTap: self.setZIndexDelayed
                            )
                                .zIndex(self.zIndexWhyCard)
                            
                            InteractiveCard(
                                title: "What?",
                                content: self.thought.description,
                                yOffset: self.calculateCardOffset(cardHeight: self.whatCardHeight, availableSpace: geometry.size.height),
                                inBackground: self.tappedWhyCard,
                                cardHeight: self.$whatCardHeight,
                                tapped: self.$tappedWhatCard,
                                animationDuration: self.cardAnimationDuration
                            )
                        }
                            .offset(y: -self.cardHeaderHeight)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: self.backButton)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
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
    
    // For card offset a distinction between devices with and without notch has to be made (because of status bar safe area)
    func calculateCardOffset(cardHeight: CGFloat, availableSpace: CGFloat) -> CGFloat {
        var availableSpace: CGFloat = availableSpace
        if (UIDevice.current.hasNotch) {
            // If screen has notch use total screen height
            availableSpace = UIScreen.main.bounds.height + self.cardHeaderHeight
        }
        
        // Calculate card y-offset by card height plus half of left space on screen minus fix value (card header)
        let cardOffset = cardHeight + (availableSpace - cardHeight - self.titleHeight) * 0.5 - 110

        // If screen has no notch add nav bar height to offset because full screen size is not used
        return UIDevice.current.hasNotch ? cardOffset : cardOffset + self.cardHeaderHeight
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
        ThoughtDetail(thought: thoughtData[3])
    }
}
