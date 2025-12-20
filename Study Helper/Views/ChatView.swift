//
//  ChatView.swift
//  Study Helper
//
//  Created by Pankaj Kumar Rana on 12/12/25.
//

import SwiftUI
import SwiftData
import Combine

struct ChatView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var holder = ViewModelHolder()
    @State private var confirmClear = false

    var body: some View {
        VStack(spacing: 0) {

            if let vm = holder.vm {
                
                HeaderView {
                    confirmClear = true
                }

                MessagesListView(vm: vm)
                    .background(Color(.systemGroupedBackground))

                if vm.isTyping {
                    TypingIndicatorView()
                        .padding(.horizontal)
                        .transition(.opacity)
                }

                InputBarView(vm: vm)
                    .background(.ultraThinMaterial)

            } else {
                ProgressView("Loading…")
                    .padding()
            }
        }
        .alert("Clear entire chat history?", isPresented: $confirmClear) {
            Button("Clear", role: .destructive) {
                holder.vm?.clearChat()
            }
            Button("Cancel", role: .cancel) {}
        }
        .onAppear {
            if holder.vm == nil {
                holder.vm = ChatViewModel(context: context)
            }
        }
    }
}

final class ViewModelHolder: ObservableObject {
    @Published var vm: ChatViewModel?
}
