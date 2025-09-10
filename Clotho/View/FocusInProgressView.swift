//
//  FocusInProgressView.swift
//  Clotho
//
//  Created by Eva Kalachik on 11/09/2025.
//

import SwiftUI

struct FocusInProgressView: View {
    @ObservedObject var vm: ViewModel
    @State private var elapsed: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var showNotesSheet = false
    @State private var notesText: String = ""

    var body: some View {
        VStack {
            if let focus = vm.currentFocus {
                Text("Focusing on \(focus.type.displayName)")
                    .font(.title.bold())
                    .padding(.bottom, 20)

                Text("\(formatTime(elapsed))")
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .padding(.bottom, 40)

                Button("End Focus") {
                    notesText = ""
                    showNotesSheet = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            } else {
                Text("No active focus")
            }
            Spacer()
        }
        .padding()
        .onAppear { startTimer() }
        .onDisappear { stopTimer() }
        .sheet(isPresented: $showNotesSheet) {
            NavigationStack {
                VStack {
                    TextEditor(text: $notesText)
                        .padding()
                        .frame(minHeight: 200)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.secondary))
                    Spacer()
                }
                .padding()
                .navigationTitle("Notes")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { showNotesSheet = false }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            vm.endFocus(withNotes: notesText.trimmingCharacters(in: .whitespacesAndNewlines))
                            showNotesSheet = false
                        }
                    }
                }
            }
        }
        .padding(.top, 300)
        .frame(maxWidth: .infinity, minHeight: 110)
        .background(LinearGradient(colors: [Color(red: 0.95, green: 0.85, blue: 0.65),
                                           Color(red: 0.85, green: 0.60, blue: 0.95)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
    }

    private func startTimer() {
        guard timer == nil, let start = vm.currentFocus?.timeStart else { return }
        elapsed = Date().timeIntervalSince(start)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsed = Date().timeIntervalSince(start)
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func formatTime(_ interval: TimeInterval) -> String {
        ViewModel.formatTime(interval)
    }
}
