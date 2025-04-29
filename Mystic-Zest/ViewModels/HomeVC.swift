//
//  HomeVC.swift
//  Mystic-Zest
//
//  Created by Jaimin Raval on 03/01/25.
//

import UIKit
import SwiftUI

class HomeVC: UIHostingController<SwippableHomeView> {

    required init? (coder: NSCoder) {
        super.init(coder:coder, rootView: SwippableHomeView())
    }
    
    override init(rootView: SwippableHomeView) {
        super.init(rootView: rootView)
    }

}


/* Steps to remove storyBoard from UIKit project:
    1. delete main.storyboard file and their respective VCs
    2. delete "storyboard name" key-value from info.plist; find it in this path(as of APR 2025): info.plist -> app scene manifest -> scene configuration -> item 0 -> storyboard name
 */
