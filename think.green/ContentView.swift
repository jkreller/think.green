//
//  ContentView.swift
//  think.green
//
//  Created by Julian Kreller on 09.01.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var tappedWhatCard: Bool = false
    @State var tappedWhyCard: Bool = false
    @State var zIndexWhyCard: Double = 0
    let cardAnimationDuration: Double = 0.3
    
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
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            VStack {
                ThoughtTitleView()
                    .scaleEffect(self.tappedWhatCard ? 0.8 : 1, anchor: .bottom)
                    .animation(.easeOut)
                
                ZStack {
                    SwipeCardView(title: "Why?", tapped: self.$tappedWhyCard, animationDuration: self.cardAnimationDuration, onTap: self.setZIndexDelayed)
                        .zIndex(self.zIndexWhyCard)
                    SwipeCardView(title: "What?", inBackground: self.tappedWhyCard, tapped: self.$tappedWhatCard, animationDuration: self.cardAnimationDuration)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
