//
//  Focus.swift
//  Clotho
//
//  Created by Eva Kalachik on 11/09/2025.
//

import Foundation
import SwiftData

enum FocusType: String, CaseIterable, Codable {
    case work
    case reading
    case study
    case other

    var displayName: String {
        switch self {
        case .work: return "Work"
        case .reading: return "Reading"
        case .study: return "Study"
        case .other: return "Other"
        }
    }
}

@Model
final class Focus {
    var id: UUID

    var typeRaw: String
    var timeStart: Date
    var timeEnd: Date?

    @Relationship(deleteRule: .cascade) var notes: [Note]?

    init(type: FocusType, timeStart: Date = Date(), timeEnd: Date? = nil) {
        self.id = UUID()
        self.typeRaw = type.rawValue
        self.timeStart = timeStart
        self.timeEnd = timeEnd
    }

    var type: FocusType {
        get { FocusType(rawValue: typeRaw) ?? .other }
        set { typeRaw = newValue.rawValue }
    }

    var duration: TimeInterval? {
        guard let end = timeEnd else { return nil }
        return end.timeIntervalSince(timeStart)
    }
}
