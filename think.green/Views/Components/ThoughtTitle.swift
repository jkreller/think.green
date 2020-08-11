//
//  ThoughtTitle.swift
//  think.green
//
//  Created by Julian Kreller on 03.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ThoughtTitle: View {
    var imageURL: String
    var title: String
    @Binding var titleHeight: CGFloat
    
    var body: some View {
        VStack {
            ImageView(from: imageURL)
                .frame(height: 100)
                .padding(.zero)

            Text(self.title)
                .modifier(LargeTitleTextStyle())
                .padding([.leading, .trailing])
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
        }
        .background(GeometryReader { geometry in
            Color.clear.onAppear {
                self.titleHeight = geometry.size.height
            }
        })
    }
}

//struct ThoughtTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThoughtDetail(thought: thoughtData[3])
//    }
//}
