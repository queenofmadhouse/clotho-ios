//
//  HistoryView.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import SwiftUI

struct HistoryView: View {
    
    var vm: ViewModel
    
    var body: some View {
        VStack {
            Text(vm.historyButtonText)
                .font(.title)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView(vm: ViewModel())
}
