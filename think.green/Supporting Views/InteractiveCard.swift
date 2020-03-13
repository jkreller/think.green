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
    @Binding var tapped: Bool
    var animationDuration: Double? = nil
    var onTap: (() -> Void)? = nil
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                if (!self.inBackground) {
                    self.tapped.toggle()
                }
                
                if (self.onTap != nil) {
                    self.onTap!()
                }
        }
    }
    
    //var drag: some Gesture {
    //    DragGesture()
    //        .onChanged { value in self.offsetY = value.translation.height }
    //        .onEnded { value in self.offsetY = 0 }
    //}
    
    var body: some View {
        Card(title: self.title, content: self.content)
            .scaleEffect(self.inBackground ? 0.9 : 1, anchor: .top)
            .opacity(self.inBackground ? 0.8 : 1)
            .padding(.top, self.inBackground ? -16 : nil)
            .padding([.leading, .trailing])
            .background(GeometryReader { geometry in
                Color.clear.onAppear {
                    self.cardHeight = geometry.size.height
                }
            })
            // Y-offset if not tapped
            .offset(y: self.tapped ? 0 : yOffset)
            .animation((self.animationDuration != nil) ? .easeOut(duration: self.animationDuration!) : .easeOut)
            .frame(height: self.tapped ? self.cardHeight : 0)
            .gesture(self.tap)
    }
}

struct SwipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtDetail(thought: thoughtData[2])
    }
}
