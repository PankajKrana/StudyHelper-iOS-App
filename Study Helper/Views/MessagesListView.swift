//
//  MessagesListView.swift
//  Study Helper
//
//  Created by Pankaj Kumar Rana on 12/12/25.
//

import SwiftUI

struct MessagesListView: View {
    @ObservedObject var vm: ChatViewModel
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 14) {
                    ForEach(vm.messages, id: \.id) { msg in
                        MessageRowView(message: msg, vm: vm)
                            .id(msg.id)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .contextMenu {
                                Button("Copy") { vm.copy(msg) }
                                Button("Delete", role: .destructive) { vm.delete(msg) }
                            }
                    }
                    
                    if vm.isLoading {
                        ProgressView().padding()
                    }
                }
                .padding(.horizontal)
            }
            .onChange(of: vm.messages.count) { _ in
                if let last = vm.messages.last {
                    withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                }
            }
        }
    }
}
