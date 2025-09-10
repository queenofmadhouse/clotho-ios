//
//  HomeView.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            FocusCard {
                VStack {
                    Text("Clotho App").font(.title.weight(.bold))
                    Text("Start a focus session to tackle your productivity and build better habits!")
                        .multilineTextAlignment(.center)
                        .font(.callout)
                }
            }
            
            HStack() {
                FocusCard {
                    VStack {
                        Text("\(vm.getSessionsCount())").font(.title.bold())
                        Text("Focus sessions")
                    }
                }
                
                FocusCard {
                    VStack {
                        Text(vm.formattedTotalFocusedTime()).font(.title.bold())
                        Text("Total focused")
                    }
                }
            }
            
            Spacer()
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color(red: 0.95, green: 0.85, blue: 0.65),
                                            Color(red: 0.85, green: 0.60, blue: 0.95)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
