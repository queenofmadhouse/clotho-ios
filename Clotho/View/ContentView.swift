//
//  ContentView.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var vm = ViewModel()
    
    init(vm: ViewModel = ViewModel()) {
        UITabBar.appearance().backgroundColor = UIColor.purple
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(vm: vm)
            }.tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                HistoryView(vm: vm)
            }.tabItem {
                Label("History", systemImage: "book")
            }
        }
            
    }
}

#Preview {
    ContentView()
}
