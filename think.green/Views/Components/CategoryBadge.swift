//
//  CategoryButton.swift
//  think.green
//
//  Created by Julian Kreller on 14.04.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI
import Parse

struct CategoryBadge: View {
    let frameFactor: CGFloat = 0.31
    
    var categoryImage: PFImageView!
    var category: ThoughtCategory {
        didSet {
            self.categoryImage.file = category.image
            self.categoryImage.loadInBackground()
        }
    }
    var parentWidth: CGFloat
    var onTap: () -> Void
    
    var body: some View {
        Button (action: self.onTap) {
            VStack(spacing: 5) {
                Image(uiImage: (categoryImage as UIImageView).image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: parentWidth * 0.13)
                Text(self.category.name)
            }
            .frame(width: parentWidth * self.frameFactor, height: parentWidth * self.frameFactor)
            .background(Color.category)
            .cornerRadius(20)
            .padding(25)
            .modifier(CategoryTextStyle(screenWidth: parentWidth))
        }
    }
}
