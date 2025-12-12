//
//  ChatViewModel.swift
//  Study Helper
//
//  Created by Pankaj Kumar Rana on 12/12/25.
//

import SwiftUI
import SwiftData
internal import Combine

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessageModel] = []
    @Published var input: String = ""
    @Published var isTyping = false
    @Published var isLoading = false

    private let ai = AIService()
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        loadHistory()
    }
    
    func loadHistory() {
        do {
            let desc = FetchDescriptor<ChatMessageModel>(sortBy: [SortDescriptor(\.date)])
            messages = try context.fetch(desc)
        } catch {
            print("Load error:", error)
        }
    }
    
    func send() {
        let text = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        let userMsg = ChatMessageModel(text: text, isUser: true)
        context.insert(userMsg)
        save()
        messages.append(userMsg)
        
        input = ""
        
        Task {
            isLoading = true
            isTyping = true

            do {
                let reply = try await ai.send(text)
                
                let aiMsg = ChatMessageModel(text: reply, isUser: false)
                context.insert(aiMsg)
                save()

                withAnimation(.easeOut(duration: 0.3)) {
                    messages.append(aiMsg)
                }
            } catch {
                let err = ChatMessageModel(text: "Error: \(error.localizedDescription)", isUser: false)
                context.insert(err)
                save()
                messages.append(err)
            }

            isLoading = false
            isTyping = false
        }
    }
    
    func delete(_ msg: ChatMessageModel) {
        context.delete(msg)
        save()
        messages.removeAll { $0.id == msg.id }
    }
    
    func copy(_ msg: ChatMessageModel) {
        UIPasteboard.general.string = msg.text
    }

    private func save() {
        do { try context.save() }
        catch { print("Save error:", error) }
    }
    
    func clearChat() {
        do {
            // Delete all messages from SwiftData
            for msg in messages {
                context.delete(msg)
            }
            try context.save()

            // Clear UI immediately
            withAnimation {
                messages.removeAll()
            }

        } catch {
            print("Failed to clear chat:", error)
        }
    }

}
