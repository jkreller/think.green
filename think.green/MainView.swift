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
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ThoughtList(showCategories: self.$showCategories, firstThoughtId: 1001)
                    .offset(x: self.showCategories ? geometry.size.width : 0)
                Categories(showCategories: self.$showCategories)
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
