//
//  Thought.swift
//  think.green
//
//  Created by Julian Kreller on 24.01.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct Thought: Hashable, Decodable, Identifiable {
    var id: Int
    let title: String
    let description: String
    let reason: String
    fileprivate var imageName: String
    var categoryId: Int
    var image: Image {
        Image(self.imageName)
    }
}
