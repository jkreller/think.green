  
/*
See LICENSE folder for this sample’s licensing information.
Abstract:
Helpers for loading images and data.
*/

import UIKit
import SwiftUI
import CoreLocation

let categoryData: [ThoughtCategory] = getThoughtCategories()
let thoughtData: [Thought] = getThoughts(thoughtCategories: categoryData)

func getThoughts(thoughtCategories: [ThoughtCategory]) -> [Thought] {
    let thought1 = Thought()
    thought1.title = "Test"
    thought1.whatText = "Test Test"
    thought1.whyText = "Because"
    thought1.category = thoughtCategories[0]
    
    return [thought1]
}

func getThoughtCategories() -> [ThoughtCategory] {
    let thoughtCategory1 = ThoughtCategory()
    thoughtCategory1.name = "Testcategory"
    
    return [thoughtCategory1]
}

