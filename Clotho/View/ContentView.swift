//
//  ContentView.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import SwiftUI
import SwiftData

enum Tabs {
    case home
    case focus
    case history
}

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var vm: ViewModel
    @State var selectedTab: Tabs = .home

    init(context: ModelContext) {
        _vm = StateObject(wrappedValue: ViewModel(context: context))
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            
            Tab("Home", systemImage: "house", value: .home) {
                HomeView(vm: vm)
            }
            Tab("Focus", systemImage: "person.fill", value: .focus) {
                if vm.currentFocus != nil {
                    FocusInProgressView(vm: vm)
                } else {
                    FocusView(vm: vm)
                }
            }
            Tab("History", systemImage: "book", value: .history) {
                HistoryView(vm: vm)
            }

        }
        .tint(Color(red: 0.95, green: 0.85, blue: 0.65))
    }
}
