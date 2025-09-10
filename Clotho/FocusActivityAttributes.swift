//
//  FocusActivityAttributes.swift
//  Clotho
//
//  Created by Eva Kalachik on 13/09/2025.
//

import SwiftUI
import ActivityKit

struct FocusActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var focusName: String
        var startTime: Date
    }
}
