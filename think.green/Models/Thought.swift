//
//  Thought.swift
//  think.green
//
//  Created by Julian Kreller on 24.01.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct Thought: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let reason: String
    let category: ThoughtCategory
    let image: StrapiImage
}
