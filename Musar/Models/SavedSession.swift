//
//  SavedSession.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import Foundation
import SwiftData

@Model
class SavedSession {
    var id: UUID
    var label: String
    var mood: String
    var genre: String
    var key: String
    var bpm: Int
    var theme: String
    var progression: String
    var trackName: String?
    var artistName: String?
    var artworkURL: String?
    var previewURL: String?
    var date: Date

    init(
        label: String,
        mood: String,
        genre: String,
        key: String,
        bpm: Int,
        theme: String,
        progression: String,
        trackName: String? = nil,
        artistName: String? = nil,
        artworkURL: String? = nil,
        previewURL: String? = nil,
        date: Date = .now
    ) {
        self.id = UUID()
        self.label = label
        self.mood = mood
        self.genre = genre
        self.key = key
        self.bpm = bpm
        self.theme = theme
        self.progression = progression
        self.trackName = trackName
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.previewURL = previewURL
        self.date = date
    }

    /// Create a SavedSession from a live InspirationResult with a custom label
    convenience init(label: String, from result: InspirationResult) {
        self.init(
            label: label,
            mood: result.mood,
            genre: result.genre,
            key: result.key,
            bpm: result.bpm,
            theme: result.theme,
            progression: result.progression,
            trackName: result.trackName,
            artistName: result.artistName,
            artworkURL: result.artworkURL,
            previewURL: result.previewURL
        )
    }

    /// Convert back to a live InspirationResult for the detail view
    func toInspirationResult() -> InspirationResult {
        InspirationResult(
            mood: mood,
            genre: genre,
            key: key,
            bpm: bpm,
            theme: theme,
            progression: progression,
            trackName: trackName,
            artistName: artistName,
            artworkURL: artworkURL,
            previewURL: previewURL,
            date: date
        )
    }
}
