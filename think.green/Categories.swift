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
    @Binding var showCategories: Bool
    
    var navBarItems: some View {
        Button(action: {
            withAnimation {
                self.showCategories = false
            }
        }) {
            Image(systemName: "rectangle.grid.1x2")
                .modifier(SymbolTextStyle())
        }
    }
    
    var body: some View {
        NavigationView {
            BaseView {
                GeometryReader { geometry in
                    ScrollView(showsIndicators: false) {
                        GridStack(rows: (categoryData.count - 1) / 2 + 1, columns: 2, hAlignment: .leading) { index, row, col in
                            if (categoryData.endIndex > index) {
                                VStack {
                                    categoryData[index].image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: geometry.size.width * 0.15)
                                    Text(categoryData[index].name)
                                }
                                .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                                .background(Color.category)
                                .cornerRadius(20)
                                .padding(25)
                                .modifier(CategoryTextStyle(screenWidth: geometry.size.width))
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: self.navBarItems)
        }
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //Categories(showCategories: .constant(true))
            //.previewDevice("iPhone SE")
            Categories(showCategories: .constant(true))
        }
    }
}
