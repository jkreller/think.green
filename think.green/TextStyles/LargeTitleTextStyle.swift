//
//  LargeTitleTextStyle.swift
//  think.green
//
//  Created by Julian Kreller on 12.02.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct LargeTitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(DefaultTextStyle())
            .font(.system(size: 45, weight: .semibold))
    }
}
