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

    var body: some Scene {
        WindowGroup {
            NavigationView {
                NewsSourceListView()
            }
        }
    }
}
