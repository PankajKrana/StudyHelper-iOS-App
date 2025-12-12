//
//  MessageRowView.swift
//  Study Helper
//
//  Created by Pankaj Kumar Rana on 12/12/25.
//

import SwiftUI

struct MessageRowView: View {
    let message: ChatMessageModel
    @ObservedObject var vm: ChatViewModel
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {

            if !message.isUser { Avatar(isUser: false) }
            else { Spacer(minLength: 4) }

            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {

                Text(message.text)
                    .padding(14)
                    .foregroundColor(message.isUser ? .white : .primary)
                    .background(message.isUser ? Color.blue.opacity(0.4) : Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .shadow(radius: 2)
                    .onTapGesture { vm.copy(message) }

                Text(message.date, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75,
                   alignment: message.isUser ? .trailing : .leading)

            if message.isUser { Avatar(isUser: true) }
            else { Spacer(minLength: 4) }
        }
        .padding(.vertical, 2)
    }
}

struct Avatar: View {
    let isUser: Bool

    var body: some View {
        Group {
            if isUser {
                Text("Me")
                    .font(.caption2.bold())
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Circle().fill(Color.blue))
            } else {
                Image(systemName: "brain.head.profile")
                    .font(.title3)
                    .padding(8)
                    .background(Circle().fill(Color(.systemGray5)))
            }
        }
        .frame(width: 40, height: 40)
    }
}


