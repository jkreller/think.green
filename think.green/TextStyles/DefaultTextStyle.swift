//
//  DefaultTextStyle.swift
//  think.green
//
//  Created by Julian Kreller on 06.02.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct DefaultTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundColor(.defaultText)
    }
}
