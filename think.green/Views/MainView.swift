//
//  MainView.swift
//  think.green
//
//  Created by Julian Kreller on 25.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var showCategories = false
    @State var chosenCategory: ThoughtCategory?
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ThoughtList(showCategories: self.$showCategories, chosenCategory: self.$chosenCategory, firstThoughtId: 1)
                    .offset(x: self.showCategories ? geometry.size.width : 0)
                Categories(showCategories: self.$showCategories, chosenCategory: self.$chosenCategory)
                    .offset(x: self.showCategories ? 0 : -geometry.size.width)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
