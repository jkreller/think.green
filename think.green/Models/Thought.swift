//
//  Thought.swift
//  think.green
//
//  Created by Julian Kreller on 24.01.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import Foundation

struct Thought {
    let title: String
    let description: String
    let reason: String
    
    init(title: String, description: String, reason: String) {
        self.title = title
        self.description = description
        self.reason = reason
    }
}
