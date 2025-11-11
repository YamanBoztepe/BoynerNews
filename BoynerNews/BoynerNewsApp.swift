//
//  BoynerNewsApp.swift
//  BoynerNews
//
//  Created by Yaman Boztepe on 11.11.2025.
//

import SwiftUI
import CoreData

@main
struct BoynerNewsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
