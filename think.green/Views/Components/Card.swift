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
        // Smaller outside padding for small screen sizes
        VStack {
            Text(self.title)
                .modifier(SecondaryTitleTextStyle())
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 25, trailing: 0))
                
            Text(self.content)
                .modifier(SecondaryDefaultTextStyle())
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 20))
        }
            .frame(maxWidth: .infinity)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(6)
            .padding([.top, .bottom])
            .background(Color.card)
            .cornerRadius(12)
            .shadow(color: Color.shadow, radius: 6, x: 0, y: 3)
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(["iPhone 6s", "iPhone 11"], id: \.self) { deviceName in
//            Card(title: "What?", content: thoughtData[3].description)
//                .previewLayout(.sizeThatFits)
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//                .padding()
//        }
//    }
//}
