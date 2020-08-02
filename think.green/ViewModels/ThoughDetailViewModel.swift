//
//  ThoughDetailViewModel.swift
//  think.green
//
//  Created by Julian Kreller on 21.06.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import Foundation

class ThoughtDetailViewModel: ObservableObject {
    var parseAPIClient = ParseAPIClient()
    @Published var thoughts: [Thought] = []
    
    init() {
        parseAPIClient.retrieveAllThoughts { thoughts, error in
            self.thoughts = thoughts!
        }
    }
}
