//
//  ThoughtList.swift
//  think.green
//
//  Created by Julian Kreller on 05.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ThoughtList: View {
    init() {
        // Make table view background transparent, seperator white and disable tap color
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .white
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            BaseView {
                List(thoughtData) { thought in
                    NavigationLink(destination: ThoughtDetail(thought: thought)) {
                        ThoughtRow(thought: thought)
                    }
                }
                .padding(.trailing, 20)
            }
        }
    }
}

struct ThoughtList_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtList()
    }
}
