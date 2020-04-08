//
//  ThoughtList.swift
//  think.green
//
//  Created by Julian Kreller on 05.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ThoughtList: View {
    @Binding var showCategories: Bool
    var firstThoughtId: Int? = nil
    @State var searchText: String = ""
    @State var isActiveFirstThought = true
    
    init(showCategories: Binding<Bool>, firstThoughtId: Int? = nil) {
        // Make table view background transparent, seperator white and disable tap color
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .white
        UITableViewCell.appearance().selectionStyle = .none

        self._showCategories = showCategories
        self.firstThoughtId = firstThoughtId
    }
    
    var navBarItems: some View {
        HStack {
            Button(action: {
                withAnimation {
                    self.showCategories = true
                }
            }) {
                Image(systemName: "square.grid.2x2")
                    .modifier(SymbolTextStyle())
            }
            SearchBar(text: self.$searchText)
                .frame(width: UIScreen.main.bounds.width - 70)
        }
    }
    
    var body: some View {
         NavigationView {
            BaseView {
                List(thoughtData.filter { thought in
                    self.searchText.isEmpty ? true : (thought.title.lowercased() as AnyObject).contains(self.searchText.lowercased())
                }) { thought in
                    if (self.firstThoughtId != nil && thought.id == self.firstThoughtId) {
                        // Call NavigationLink with isActive true for immediately switching to first thought
                        NavigationLink(destination: ThoughtDetail(thought: thought), isActive: self.$isActiveFirstThought) {
                            ThoughtRow(thought: thought)
                        }
                    } else {
                        NavigationLink(destination: ThoughtDetail(thought: thought)) {
                            ThoughtRow(thought: thought)
                        }
                    }
                }
                .padding(.trailing, 20)
                .padding(.top, 5)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: self.navBarItems)
        }
    }
}

struct ThoughtList_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtList(showCategories: .constant(false))
    }
}
