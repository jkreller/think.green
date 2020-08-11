//
//  StrapiAPIClient.swift
//  think.green
//
//  Created by Julian Kreller on 10.08.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import UIKit

struct StrapiAPIClient {
    static let baseURL = "http://localhost:1337"
    
    func fetchThoughts(completion: @escaping ([Thought]?, Error?) -> Void) {
        let urlString = "\(StrapiAPIClient.baseURL)/thoughts"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            do {
                let thoughts = try JSONDecoder().decode([Thought].self, from: data!)
                completion(thoughts, nil)
            } catch let jsonError {
                completion(nil, jsonError)
            }
        }.resume()
    }
    
    func fetchThoughtCategories(completion: @escaping ([ThoughtCategory]?, Error?) -> Void) {
        let urlString = "\(StrapiAPIClient.baseURL)/thought-categories"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            do {
                let thoughtCategories = try JSONDecoder().decode([ThoughtCategory].self, from: data!)
                completion(thoughtCategories, nil)
            } catch let jsonError {
                completion(nil, jsonError)
            }
        }.resume()
    }
}
