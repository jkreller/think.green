//
//  ThoughtDetail.swift
//  think.green
//
//  Created by Julian Kreller on 09.01.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ThoughtDetailNew: View {
    // Init properties
    let thought: Thought
    
    // State properties
    @State var titleHeight: CGFloat = 0
    @State var whyTapped: Bool = false
    @State var whatTapped: Bool = false

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
                            .offset(y: geometry.size.height / 2 - titleHeight / 1.5)
                        
                        ZStack {
                            InteractiveCardNew(
                                title: "Why?",
                                content: self.thought.reason
                            ).onTapGesture {
                                self.whyTapped = true
                            }
                            
                            InteractiveCardNew(
                                title: "What?",
                                content: self.thought.description
                            ).onTapGesture {
                                self.whatTapped = true
                            }
                        }
                        .padding(.horizontal, 20)
                        .offset(y: geometry.size.height - 260)
                    }
                }
            }
            .navigationBarItems(leading: self.backButton)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct ThoughtDetailNew_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtDetailNew(thought: thoughtData[0])
    }
}
