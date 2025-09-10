//
//  FocusView.swift
//  Clotho
//
//  Created by Eva Kalachik on 11/09/2025.
//

import SwiftUI

struct FocusView: View {
    @ObservedObject var vm: ViewModel
    @State private var navigateToProgress = false

    var body: some View {
        VStack(spacing: 16) {
            Button {
                vm.startFocus(type: .work)
                navigateToProgress = true
            } label: {
                FocusCard {
                    VStack {
                        Text(FocusType.work.displayName).font(.title.weight(.bold))
                        Text("Start focus")
                    }
                }
            }.buttonStyle(PlainButtonStyle())

            Button {
                vm.startFocus(type: .reading)
                navigateToProgress = true
            } label: {
                FocusCard {
                    VStack {
                        Text(FocusType.reading.displayName).font(.title.weight(.bold))
                        Text("Start focus")
                    }
                }
            }.buttonStyle(PlainButtonStyle())

            Spacer()
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color(red: 0.95, green: 0.85, blue: 0.65),
                                           Color(red: 0.85, green: 0.60, blue: 0.95)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
