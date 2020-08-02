//
//  CategoriesViewModel.swift
//  think.green
//
//  Created by Julian Kreller on 03.07.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    var parseAPIClient = ParseAPIClient()
    @Published var thoughtCategories: [ThoughtCategory] = []
    
    init() {
        parseAPIClient.retrieveAllThoughtCategories { thoughtCategories, error in
            self.thoughtCategories = thoughtCategories!
        }
    }
}
