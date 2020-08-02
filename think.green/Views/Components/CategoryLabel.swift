//
//  CategoryLabel.swift
//  think.green
//
//  Created by Julian Kreller on 15.04.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct CategoryLabel: View {
    var category: ThoughtCategory
    var didRemoveCategory: () -> Void

    var body: some View {
        HStack {
            Text("Category: \(self.category.name)")
            Button(action: self.didRemoveCategory) {
                Image(systemName: "xmark")
                    .font(.system(size: 11))
            }
        }
        .padding([.leading, .trailing], 10)
        .padding([.top, .bottom], 5)
        .background(Color.white.opacity(0.2))
        .foregroundColor(.white)
        .cornerRadius(25)
    }
}

struct CategoryLabel_Previews: PreviewProvider {
    static var previews: some View {
        CategoryLabel(category: categoryData[0], didRemoveCategory: {})
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.background)
    }
}
