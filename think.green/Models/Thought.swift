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
    var category: Category
    var image: Image {
        Image(self.imageName)
    }

    enum Category: String, CaseIterable, Codable, Hashable {
        case carbonDioxide = "Carbon dioxide"
        case plastic = "Plastic"
        case water = "Water"
    }
}
