//
//  Note.swift
//  Clotho
//
//  Created by Eva Kalachik on 11/09/2025.
//

import Foundation
import SwiftData

@Model
final class Note {
    var id: UUID
    var text: String
    var createdAt: Date

    init(text: String, createdAt: Date = Date()) {
        self.id = UUID()
        self.text = text
        self.createdAt = createdAt
    }
}
