//
//  Categories.swift
//  think.green
//
//  Created by Julian Kreller on 25.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI
import Foundation

struct Categories: View {
    // Data
    @ObservedObject var viewModel = CategoriesViewModel()
    
    // Animation
    @Binding var showCategories: Bool
    @Binding var chosenCategory: ThoughtCategory?
    
    var navBarItems: some View {
        Button(action: self.hideCategories) {
            Image(systemName: "rectangle.grid.1x2")
                .modifier(SymbolTextStyle())
        }
    }
    
    var body: some View {
        NavigationView {
            BaseView {
                GeometryReader { geometry in
                    ScrollView(showsIndicators: false) {
                        GridStack(rows: (self.viewModel.thoughtCategories.count - 1) / 2 + 1, columns: 2, hAlignment: .leading) { index, row, col in
                            if self.viewModel.thoughtCategories.endIndex > index {
                                // Don't show last element if it's an odd amount of elements
                                CategoryBadge(
                                    category: self.viewModel.thoughtCategories[index],
                                    parentWidth: geometry.size.width,
                                    onTap: {
                                        self.chooseCategory(category: self.viewModel.thoughtCategories[index])
                                    }
                                )
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: self.navBarItems)
        }
    }
    
    func hideCategories() {
        withAnimation {
            self.showCategories = false
        }
    }
    
    func chooseCategory(category: ThoughtCategory) {
        self.hideCategories()
        self.chosenCategory = category
    }
}

//struct Categories_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Categories(showCategories: .constant(true), chosenCategory: .constant(categoryData[0]))
//        }
//    }
//}
