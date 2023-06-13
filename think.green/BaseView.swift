//
//  BaseView.swift
//  think.green
//
//  Created by Julian Kreller on 06.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct BaseView<Content: View>: View {
    let viewBuilder: () -> Content
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            self.viewBuilder()
        }
    }
}
