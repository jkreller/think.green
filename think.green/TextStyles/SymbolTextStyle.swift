//
//  SymbolTextStyle.swift
//  think.green
//
//  Created by Julian Kreller on 13.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct SymbolTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(DefaultTextStyle())
            .font(.system(size: 25))
    }
}
