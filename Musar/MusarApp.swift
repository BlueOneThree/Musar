//
//  MusarApp.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI
import SwiftData

@main
struct MusarApp: App {
    var body: some Scene {
        WindowGroup {
            MainViewView()
        }
        .modelContainer(for: SavedSession.self)
    }
}
