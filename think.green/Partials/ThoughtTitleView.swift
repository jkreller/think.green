//
//  ThoughtTitle.swift
//  think.green
//
//  Created by Julian Kreller on 03.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ThoughtTitleView: View {
    var body: some View {
        VStack {
            Image("bike")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .padding(.zero)

            Text("Drive by bike!")
                .modifier(LargeTitleTextStyle())
                .padding(.bottom)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct ThoughtTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
