//
//  Activity_WidgitLiveActivity.swift
//  Activity-Widgit
//
//  Created by Jaimin Raval on 05/08/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Activity_WidgitAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Activity_WidgitLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Activity_WidgitAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Activity_WidgitAttributes {
    fileprivate static var preview: Activity_WidgitAttributes {
        Activity_WidgitAttributes(name: "World")
    }
}

extension Activity_WidgitAttributes.ContentState {
    fileprivate static var smiley: Activity_WidgitAttributes.ContentState {
        Activity_WidgitAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Activity_WidgitAttributes.ContentState {
         Activity_WidgitAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Activity_WidgitAttributes.preview) {
   Activity_WidgitLiveActivity()
} contentStates: {
    Activity_WidgitAttributes.ContentState.smiley
    Activity_WidgitAttributes.ContentState.starEyes
}
