//
//  ClothoApp.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import SwiftUI

@main
struct ClothoApp: App {
    
    let vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(vm: vm)
        }
    }
}
