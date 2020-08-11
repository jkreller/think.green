//
//  StrapiAPIImageLoader.swift
//  think.green
//
//  Created by Julian Kreller on 11.08.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import Foundation

class StrapiAPIImageLoader: ObservableObject {
    @Published var data: Data?
    
    init(imageUrlString: String) {
        guard let url = URL(string: StrapiAPIClient.baseURL + imageUrlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch image:", error)
                return
            }
            print("load image")
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
