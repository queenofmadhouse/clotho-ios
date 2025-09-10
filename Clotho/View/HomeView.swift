//
//  HomeView.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import SwiftUI

struct HomeView: View {
    
    var vm: ViewModel
    
    var body: some View {
        VStack {
            Text(vm.homeButtonText)
                .font(.title)
                .background(Rectangle().fill(Color.blue).frame(width: 300, height: 100).cornerRadius(10))
                .padding(.top, 100)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView(vm: ViewModel())
}
