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
    @Binding var chosenCategory: Category?
    var firstThoughtId: Int? = nil
    @State var searchText: String = ""
    @State var isActiveFirstThought = true
    
    init(showCategories: Binding<Bool>, chosenCategory: Binding<Category?>, firstThoughtId: Int? = nil) {
        // Make table view background transparent, seperator white and disable tap color
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .white
        UITableViewCell.appearance().selectionStyle = .none

        self._showCategories = showCategories
        self._chosenCategory = chosenCategory
        self.firstThoughtId = firstThoughtId
    }
    
    var body: some View {
         NavigationView {
            BaseView {
                VStack(alignment: .trailing, spacing: 0) {
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
                    
                    if (self.chosenCategory != nil) {
                        CategoryLabel(category: self.chosenCategory!, didRemoveCategory: {
                            self.chosenCategory = nil
                        }).padding(.top, 10)
                    }
                    
                    List(thoughtData.filter(self.filterThoughts)) { thought in
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
                    .padding(.top, 5)
                }
                .padding(.trailing, 20)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    func filterThoughts(thought: Thought) -> Bool {
        let lowercasedTitle = thought.title.lowercased()
        let lowercasedSearchText = self.searchText.lowercased()
        
        // If category is selected try to match thought category id with chodes category id, otherwise set to true
        let matchesCategory = self.chosenCategory == nil || thought.categoryId == self.chosenCategory!.id
        
        // Select thought if search text empty and category matches or if search text is not empty, thought title contains search text and category matches
        return (self.searchText.isEmpty || lowercasedTitle.contains(lowercasedSearchText)) && matchesCategory
    }
}

struct ThoughtList_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtList(showCategories: .constant(false), chosenCategory: .constant(categoryData[0]))
    }
}
