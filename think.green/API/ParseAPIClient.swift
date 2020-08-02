//
//  APIRequest.swift
//  think.green
//
//  Created by Julian Kreller on 30.05.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import Foundation
import Parse

struct ParseAPIClient {
    func retrieveAllThoughts(completion: @escaping ThoughtsCompletionHandler) {
        let query = Thought.query()
        query?.findObjectsInBackground { thoughts, error in
            completion(thoughts as? [Thought], error)
        }
    }
    
    func retrieveAllThoughtCategories(completion: @escaping ThoughtCategoriesCompletionHandler) {
        let query = ThoughtCategory.query()
        query?.findObjectsInBackground { thoughtCategories, error in
            completion(thoughtCategories as? [ThoughtCategory], error)
        }
    }
    
}

typealias ThoughtsCompletionHandler = ([Thought]?, Error?) -> Void
typealias ThoughtCategoriesCompletionHandler = ([ThoughtCategory]?, Error?) -> Void
