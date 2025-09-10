//
//  ViewModel.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import ActivityKit
import SwiftUI
import SwiftData

@MainActor
final class ViewModel: ObservableObject {
    private var activity: Activity<FocusActivityAttributes>? = nil
    @Published var homeButtonText: String = "Home"
    @Published var historyButtonText: String = "History"
    
    @Published private(set) var sessions: [Focus] = []
    @Published private(set) var totalFocusedTime: TimeInterval = 0
    @Published var currentFocus: Focus?
    
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        refresh()
    }
    
    // MARK: - CRUD
    
    func refresh() {
        do {
            let descriptor = FetchDescriptor<Focus>(sortBy: [SortDescriptor(\.timeStart, order: .reverse)])
            sessions = try context.fetch(descriptor)
            totalFocusedTime = sessions.compactMap { $0.duration }.reduce(0, +)
            currentFocus = sessions.first(where: { $0.timeEnd == nil })
        } catch {
            print("Refresh error:", error)
            sessions = []
            totalFocusedTime = 0
            currentFocus = nil
        }
    }
    
    func getSessionsCount() -> Int { sessions.count }
    
    func formattedTotalFocusedTime() -> String {
        Self.formatTime(totalFocusedTime)
    }
    
    func startFocus(type: FocusType) {
        if currentFocus != nil {
            return
        }
        let f = Focus(type: type, timeStart: Date(), timeEnd: nil)
        context.insert(f)
        currentFocus = f
        do {
            try context.save()
        } catch {
            print("Save error on start:", error)
        }
        startActivity(focusName: type.rawValue)
        refresh()
    }
    
    func endFocus(withNotes notesText: String?) {
        guard let f = currentFocus else { return }
        endActivity()
        f.timeEnd = Date()
        if let txt = notesText, !txt.isEmpty {
            let note = Note(text: txt)
            context.insert(note)
            if f.notes == nil { f.notes = [note] } else { f.notes?.append(note) }
        }
        currentFocus = nil
        do {
            try context.save()
        } catch {
            print("Save error on end:", error)
        }
        refresh()
    }
    
    // MARK: - Live Activity
    
    private func startActivity(focusName: String) {
        let attributes = FocusActivityAttributes()
        guard let start = currentFocus?.timeStart else { return }
        let initialState = FocusActivityAttributes.ContentState(
            focusName: focusName,
            startTime: start
        )
        
        let content = ActivityContent<FocusActivityAttributes.ContentState>(state: initialState, staleDate: .none)
        
        do {
            activity = try Activity<FocusActivityAttributes>.request(
                attributes: attributes,
                content: content,
                pushType: nil
            )
        } catch {
            print("Activity start error:", error)
        }
    }
    
    private func endActivity() {
        guard let activity = activity else { return }

        let finalState = FocusActivityAttributes.ContentState(
            focusName: currentFocus?.type.rawValue ?? "",
            startTime: currentFocus?.timeStart ?? Date()
        )
        let content = ActivityContent(state: finalState, staleDate: nil)

        Task {
            await activity.end(content, dismissalPolicy: .immediate)
            print("Activity ended")
            self.activity = nil
        }
    }
    
    static func formatTime(_ seconds: TimeInterval) -> String {
        let total = Int(seconds)
        let hours = total / 3600
        let minutes = (total % 3600) / 60
        if hours > 0 {
            return String(format: "%dh %dm", hours, minutes)
        } else {
            return String(format: "%dm %02ds", minutes, total % 60)
        }
    }
}
