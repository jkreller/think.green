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
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            VStack {
                ThoughtTitleView()
                    .scaleEffect(self.tappedWhatCard ? 0.8 : 1, anchor: .bottom)
                
                ZStack {
                    SwipeCardView(title: "Why?", tapped: self.$tappedWhyCard)
                        .zIndex(self.tappedWhatCard ? 1 : 0)
                    SwipeCardView(title: "What?", inBackground: self.tappedWhyCard, tapped: self.$tappedWhatCard)
                }
            }
            .animation(.easeOut)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
