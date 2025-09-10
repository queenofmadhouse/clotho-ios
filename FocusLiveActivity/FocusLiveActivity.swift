//
//  FocusLiveActivity.swift
//  FocusLiveActivity
//
//  Created by Eva Kalachik on 13/09/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct FocusActivityView: View {
    var context: ActivityViewContext<FocusActivityAttributes>

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "bolt.fill")
                .font(.title2)
                .symbolRenderingMode(.hierarchical)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 6) {
                Text(context.state.focusName)
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Text(context.state.startTime, style: .timer)
                    .font(.subheadline)
                    .monospacedDigit()
            }

            Spacer()
        }
        .padding(12)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 0.85, blue: 0.65),
                    Color(red: 0.85, green: 0.60, blue: 0.95)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
@main
struct FocusLiveActivity: Widget {
    let kind: String = "FocusLiveActivity"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FocusActivityAttributes.self) { context in
            FocusActivityView(context: context)
        } dynamicIsland: { _ in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    Text("")
                }
            } compactLeading: {
                Text("")
            } compactTrailing: {
                Text("")
            } minimal: {
                Text("")
            }
        }
    }
}
