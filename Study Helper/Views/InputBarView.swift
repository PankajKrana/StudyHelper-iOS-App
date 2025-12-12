//
//  InputBarView.swift
//  Study Helper
//
//  Created by Pankaj Kumar Rana on 12/12/25.
//
import SwiftUI

struct InputBarView: View {
    @ObservedObject var vm: ChatViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 12) {
            TextField("Ask anything…", text: Binding(
                get: { vm.input ?? "" },
                set: { vm.input = $0 }
            ))
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .focused($isFocused)
            .onSubmit { vm.send() }

            Button {
                vm.send()
                isFocused = false
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(((vm.input.isEmpty) != nil) ? .white : .blue)
                    .padding(12)
                    .background(
                        (vm.input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false)
                        ? Color.blue
                        : Color.gray.opacity(0.6)
                    )
                    .clipShape(Circle())
            }
            .disabled(vm.input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        }
        .padding()
    }
}


