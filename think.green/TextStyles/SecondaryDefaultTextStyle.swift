//
//  DefaultSecondaryTextStyle.swift
//  think.green
//
//  Created by Julian Kreller on 12.02.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct SecondaryDefaultTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundColor(.secondaryDefaultText)
    }
}
