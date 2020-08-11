//
//  CategoriesViewModel.swift
//  think.green
//
//  Created by Julian Kreller on 11.08.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    var apiClient = StrapiAPIClient()
    @Published var thoughtCategories: [ThoughtCategory] = []
    
    init() {
        apiClient.fetchThoughtCategories() { (thoughtCategories, error) in
            if let error = error {
                print("Failed to fetch thought categories:", error)
                return
            }
            
            self.thoughtCategories = thoughtCategories!
        }
    }
}
