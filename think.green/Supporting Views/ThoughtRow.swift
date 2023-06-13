//
//  ThoughtRow.swift
//  think.green
//
//  Created by Julian Kreller on 05.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ThoughtRow: View {
    var thought: Thought
    
    var body: some View {
        HStack {
            Spacer()
            Text(thought.title)
                .modifier(ThoughtRowTextStyle())
                .padding(.trailing)
            thought.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 45)
        }.padding()
    }
}

struct ThoughtRow_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtRow(thought: thoughtData[0])
            .previewLayout(.sizeThatFits)
            .frame(width: 300, height: 65)
            .padding()
    }
}
