//
//  SavedViewModel.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI
import SwiftData

// MARK: - Filter Options

enum SavedFilter: String, CaseIterable {
    case all = "All"
    case mood = "Mood"
    case recent = "Recent"
}

// MARK: - ViewModel

@Observable
class SavedViewModel {
    var filter: SavedFilter = .all

    /// Save an InspirationResult with a custom label
    func save(_ result: InspirationResult, label: String, context: ModelContext) {
        let session = SavedSession(label: label, from: result)
        context.insert(session)
        try? context.save()
        print("✅ Saved: \(label) — \(session.mood)")
    }

    /// Delete a saved session
    func delete(_ session: SavedSession, context: ModelContext) {
        context.delete(session)
    }

    /// Apply the current filter to a list of sessions
    func filtered(_ sessions: [SavedSession]) -> [SavedSession] {
        switch filter {
        case .all:
            // Most recent first
            return sessions.sorted { $0.date > $1.date }

        case .mood:
            // Grouped alphabetically by mood name
            return sessions.sorted { $0.mood < $1.mood }

        case .recent:
            // Only sessions from the last 7 days
            let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: .now) ?? .now
            return sessions
                .filter { $0.date >= oneWeekAgo }
                .sorted { $0.date > $1.date }
        }
    }
}
