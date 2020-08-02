//
//  Category.swift
//  think.green
//
//  Created by Julian Kreller on 05.04.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import Foundation
import Parse

/*
struct ThoughtCategory: Decodable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    var image: Image {
        Image(self.imageName)
    }
}
*/
class ThoughtCategory: PFObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var image: PFFileObject
    
    static func parseClassName() -> String {
        return "ThoughtCategory"
    }
}
