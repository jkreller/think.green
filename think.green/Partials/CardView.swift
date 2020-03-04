//
//  Card.swift
//  think.green
//
//  Created by Julian Kreller on 19.02.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .modifier(SecondaryTitleTextStyle())
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                
            Text("If possible, take the bike instead of other means of transport!")
                .modifier(SecondaryDefaultTextStyle())
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing, .bottom])
        }
        .padding()
        .background(Color.card)
        .cornerRadius(12)
        .shadow(color: Color.shadow, radius: 6, x: 0, y: 3)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "What?")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
