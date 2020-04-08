//
//  CategoryTextStyle.swift
//  think.green
//
//  Created by Julian Kreller on 05.04.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct CategoryTextStyle: ViewModifier {
    var screenWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.categoryContent)
            .font(.system(size: self.screenWidth * 0.06, weight: .medium))
    }
}
