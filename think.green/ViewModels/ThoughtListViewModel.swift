//
//  ThoughtListViewModel.swift
//  think.green
//
//  Created by Julian Kreller on 10.08.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import Foundation

class ThoughtListViewModel: ObservableObject {
    @Published var thoughts: [Thought] = []
    var apiClient = StrapiAPIClient()
    
    init() {
        apiClient.fetchThoughts() { (thoughts, error) in
            if let error = error {
                print("Failed to fetch thoughts:", error)
                return
            }
            
            DispatchQueue.main.async {
                self.thoughts.append(contentsOf: thoughts!)
            }
        }
    }
}
