//
//  GridStack.swift
//  think.green
//
//  Created by Julian Kreller on 05.04.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    var hAlignment: HorizontalAlignment
    var vAlignment: VerticalAlignment
    let content: (Int, Int, Int) -> Content

    var body: some View {
        VStack(alignment: self.hAlignment) {
            ForEach(0 ..< self.rows) { row in
                HStack(alignment: self.vAlignment) {
                    ForEach(0 ..< self.columns) { col in
                        self.content(row * self.columns + col, row, col) // Returns index, actual row and actual column (started with 0)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, hAlignment: HorizontalAlignment = .center, vAlignment: VerticalAlignment = .center, @ViewBuilder content: @escaping (Int, Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.hAlignment = hAlignment
        self.vAlignment = vAlignment
        self.content = content
    }
}
