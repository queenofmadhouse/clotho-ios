//
//  HistoryView.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(vm.sessions.indices, id: \.self) { idx in
                    let s = vm.sessions[idx]
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(s.type.displayName)
                                .font(.headline)
                            Spacer()
                            if let dur = s.duration {
                                Text(ViewModel.formatTime(dur))
                                    .font(.subheadline)
                            } else {
                                Text("In progress")
                                    .font(.subheadline)
                                    .foregroundColor(.accentColor)
                            }
                        }
                        Text("Start: \(dateFormatter.string(from: s.timeStart))")
                            .font(.caption)
                        if let end = s.timeEnd {
                            Text("End:   \(dateFormatter.string(from: end))")
                                .font(.caption)
                        }
                        if let notes = s.notes, !notes.isEmpty {
                            Divider()
                            ForEach(notes, id: \.id) { n in
                                Text(n.text)
                                    .font(.footnote)
                            }
                        }
                    }
                    .foregroundColor(Color(red: 0.65, green: 0.40, blue: 0.75))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.ultraThinMaterial)
                    )
                    .padding(.top, idx == 0 ? 40 : 0)
                    .padding(.horizontal)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color(red: 0.95, green: 0.85, blue: 0.65),
                                            Color(red: 0.85, green: 0.60, blue: 0.95)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f
    }
}
