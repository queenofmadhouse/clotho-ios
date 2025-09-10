//
//  FocusCard.swift
//  Clotho
//
//  Created by Eva Kalachik on 11/09/2025.
//

import SwiftUI

struct FocusCard<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, minHeight: 110)
            .padding()
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial))
            .foregroundColor(Color(red: 0.65, green: 0.40, blue: 0.75))
            .padding(.horizontal)
    }
}
