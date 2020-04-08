//
//  UINavigationControllerExtension.swift
//  think.green
//
//  Created by Julian Kreller on 07.04.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
      
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = UIColor(named: "background")
        standardAppearance.shadowColor = .clear

        //let compactAppearance = UINavigationBarAppearance()
        //compactAppearance.backgroundColor = UIColor(named: "background")
        //compactAppearance.shadowColor = .clear
        
        //let scrollEdgeAppearance = UINavigationBarAppearance()
        //scrollEdgeAppearance.backgroundColor = UIColor(named: "background")
        //scrollEdgeAppearance.shadowColor = .clear
        
        navigationBar.standardAppearance = standardAppearance
        //navigationBar.compactAppearance = compactAppearance
        //navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
}
