//
//  HeaderView.swift
//  Study Helper
//
//  Created by Pankaj Kumar Rana on 12/12/25.
//

import SwiftUI

struct HeaderView: View {
    @State private var showingMenu = false
    var onClearChat: () -> Void

    var body: some View {
        HStack(spacing: 12) {

            Image(systemName: "bolt.fill")
                .foregroundColor(.white)
                .padding(8)
                .background(Circle().fill(Color.blue))
                .shadow(radius: 3, y: 2)

            VStack(alignment: .leading, spacing: 2) {
                Text("AI Assist")
                    .font(.headline)
                Text("Ask me anything…")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Menu {
                Button("Clear Chat", role: .destructive) {
                    onClearChat()
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .overlay(Divider(), alignment: .bottom)
    }
}
