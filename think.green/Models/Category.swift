//
//  Category.swift
//  think.green
//
//  Created by Julian Kreller on 05.04.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct Category: Hashable, Decodable, Identifiable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    var image: Image {
        Image(self.imageName)
    }
}
