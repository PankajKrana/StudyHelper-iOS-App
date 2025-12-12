//
//  Study_HelperApp.swift
//  Study Helper
//
//  Created by Pankaj Kumar Rana on 12/12/25.
//

import SwiftUI
import SwiftData

@main
struct Study_HelperApp: App {
    var container: ModelContainer = {
        try! ModelContainer(for: ChatMessageModel.self)
    }()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ChatView()
            }
            .modelContainer(container)
        }
    }
}
