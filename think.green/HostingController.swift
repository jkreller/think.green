//
//  HostingController.swift
//  think.green
//
//  Created by Julian Kreller on 03.03.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import UIKit
import SwiftUI

class HostingController: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
