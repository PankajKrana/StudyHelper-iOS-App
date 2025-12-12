//
//  ChatMessageModel.swift
//  Study Helper
//
//  Created by Pankaj Kumar Rana on 12/12/25.
//

import SwiftData
import Foundation

@Model
class ChatMessageModel {
    @Attribute(.unique) var id: UUID
    var text: String
    var isUser: Bool
    var date: Date
    
    init(text: String, isUser: Bool, date: Date = Date()) {
        self.id = UUID()
        self.text = text
        self.isUser = isUser
        self.date = date
    }
}
