//
//  LandmarkRowTextStyle.swift
//  think.green
//
//  Created by Julian Kreller on 06.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ThoughtRowTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.defaultText)
            .font(.system(size: 23, weight: .semibold))
    }
}
