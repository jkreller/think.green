//
//  SearchBar.swift
//  think.green
//
//  Created by Julian Kreller on 23.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search", text: $text)
            .padding(10)
            .background(Color.defaultText.opacity(0.4))
            .cornerRadius(50)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background
            SearchBar(text: .constant(""))
        }
        .previewLayout(.fixed(width: 300, height: 100))
    }
}
