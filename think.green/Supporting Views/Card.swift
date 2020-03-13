//
//  Card.swift
//  think.green
//
//  Created by Julian Kreller on 19.02.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct Card: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack {
            Text(self.title)
                .modifier(SecondaryTitleTextStyle())
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                
            Text(self.content)
                .modifier(SecondaryDefaultTextStyle())
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing, .bottom])
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .padding()
        .background(Color.card)
        .cornerRadius(12)
        .shadow(color: Color.shadow, radius: 6, x: 0, y: 3)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Card(title: "What?", content: thoughtData[0].description)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
