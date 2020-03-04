//
//  TitleGreenTextStyle.swift
//  think.green
//
//  Created by Julian Kreller on 12.02.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct SecondaryTitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30, weight: .medium))
            .foregroundColor(.secondaryTitleText)
    }
}
