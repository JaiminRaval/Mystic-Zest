//
//  Activity_WidgitBundle.swift
//  Activity-Widgit
//
//  Created by Jaimin Raval on 05/08/25.
//

import WidgetKit
import SwiftUI

@main
struct Activity_WidgitBundle: WidgetBundle {
    var body: some Widget {
        Activity_Widgit()
        Activity_WidgitControl()
        Activity_WidgitLiveActivity()
    }
}
