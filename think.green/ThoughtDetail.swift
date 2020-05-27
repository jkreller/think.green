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
    @State var zIndexWhyCard: Double? = 0
    @State var whatCardHeight: CGFloat = 0
    @State var whyCardHeight: CGFloat = 0
    @State var whatCardDragFactor: CGFloat = 0
    @State var whyCardDragFactor: CGFloat = 0
    @State var titleHeight: CGFloat = 0

    // Environment variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var backButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .modifier(SymbolTextStyle())
        }
    }
    
    var body: some View {
        return NavigationView {
            BaseView {
                GeometryReader { geometry in
                    VStack {
                        ThoughtTitle(image: self.thought.image, title: self.thought.title, titleHeight: self.$titleHeight)
                            // Set scale effect to decrease size according to what-card drag
                            .scaleEffect(1 - (0.2 * self.whatCardDragFactor), anchor: .bottom)
                            .animation(.easeOut)
                            .padding(.top, 20)
                            // Set offset when card is not tapped to move with card
                            .offset(y: -InteractiveCard.cardHeaderHeight * 0.5)
                        
                        ZStack {
                            InteractiveCard(
                                title: "Why?",
                                content: self.thought.reason,
                                yOffset: self.calculateCardOffset(cardHeight: self.whyCardHeight, availableSpace: geometry.size.height),
                                cardHeight: self.$whyCardHeight,
                                zIndex: self.$zIndexWhyCard,
                                revealFactor: self.$whyCardDragFactor
                            )
                                .zIndex(self.zIndexWhyCard!)
                            
                            InteractiveCard(
                                title: "What?",
                                content: self.thought.description,
                                yOffset: self.calculateCardOffset(cardHeight: self.whatCardHeight, availableSpace: geometry.size.height),
                                inBackgroundFactor: self.$whyCardDragFactor,
                                cardHeight: self.$whatCardHeight,
                                revealFactor: self.$whatCardDragFactor
                            )
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: self.backButton)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    // For card offset a distinction between devices with and without notch has to be made (because of status bar safe area)
    func calculateCardOffset(cardHeight: CGFloat, availableSpace: CGFloat) -> CGFloat {
        var availableSpace: CGFloat = availableSpace
        if (UIDevice.current.hasNotch) {
            // If screen has notch use total screen height
            availableSpace = UIScreen.main.bounds.height + InteractiveCard.cardHeaderHeight
        }
        
        // Calculate card y-offset by card height plus half of left space on screen minus fix value (card header)
        let cardOffset = cardHeight + (availableSpace - cardHeight - self.titleHeight) * 0.5 - 110

        // If screen has no notch add nav bar height to offset because full screen size is not used
        return UIDevice.current.hasNotch ? cardOffset : cardOffset + InteractiveCard.cardHeaderHeight
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
        ThoughtDetail(thought: thoughtData[4])
    }
}
