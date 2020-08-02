//
//  Thought.swift
//  think.green
//
//  Created by Julian Kreller on 24.01.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import Foundation
import Parse

/*
struct Thought: Decodable, Identifiable {
 var id: Int
 let title: String
 let description: String
 let reason: String
 fileprivate var imageName: String
 var categoryId: Int
 var image: Image {
     Image(self.imageName)
}
*/
class Thought: PFObject, PFSubclassing, Identifiable {
    let id = 0
    @NSManaged var title: String
    @NSManaged var whatText: String
    @NSManaged var whyText: String
    @NSManaged var image: PFFileObject
    @NSManaged var category: ThoughtCategory
    var uiImage: UIImage?
    
    func loadImage() {
        image.getDataInBackground { (imageData: Data?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let imageData = imageData {
                self.uiImage = UIImage(data: imageData)
            }
        }
    }
    
    static func parseClassName() -> String {
        return "Thought"
    }
}
