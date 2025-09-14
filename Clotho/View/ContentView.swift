//
//  ContentView.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import SwiftUI
import SwiftData

enum Tabs: CaseIterable {
    case home, focus, history
}

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var vm: ViewModel
    @State var selectedTab: Tabs = .home

    private let tabsOrder: [Tabs] = [.home, .focus, .history]
    init(context: ModelContext) {
        _vm = StateObject(wrappedValue: ViewModel(context: context))
    }

    var body: some View {
        GeometryReader { geo in
            TabView(selection: $selectedTab) {

                Tab("Home", systemImage: "house", value: Tabs.home) {
                    HomeView(vm: vm)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                Tab("Focus", systemImage: "person.fill", value: Tabs.focus) {
                    if vm.currentFocus != nil {
                        FocusInProgressView(vm: vm)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        FocusView(vm: vm)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }

                Tab("History", systemImage: "book", value: Tabs.history) {
                    HistoryView(vm: vm)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .tint(Color(red: 0.95, green: 0.85, blue: 0.65))
            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded { value in
                    handleDrag(value: value, width: geo.size.width)
                }
            )
        }
    }

    private func handleDrag(value: DragGesture.Value, width: CGFloat) {
        let threshold: CGFloat = 20
        let horizontal = value.translation.width

        if horizontal < -threshold {
            goToNext()
        } else if horizontal > threshold {
            goToPrevious()
        }
    }

    private func goToNext() {
        if let idx = tabsOrder.firstIndex(of: selectedTab), idx < tabsOrder.count - 1 {
            withAnimation { selectedTab = tabsOrder[idx + 1] }
        }
    }

    private func goToPrevious() {
        if let idx = tabsOrder.firstIndex(of: selectedTab), idx > 0 {
            withAnimation { selectedTab = tabsOrder[idx - 1] }
        }
    }
}
