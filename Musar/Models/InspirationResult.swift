//
//  InspirationResult.swift
//  Musar
//
//  Created by The Blue  on 26/03/2026.
//

import Foundation
import Combine

class InspirationResult: Identifiable, ObservableObject {
    let id = UUID()
    let mood: String
    let genre: String

    @Published var key: String
    @Published var bpm: Int
    @Published var theme: String
    @Published var progression: String

    @Published var trackName: String?
    @Published var artistName: String?
    @Published var artworkURL: String?
    @Published var previewURL: String?

    let date: Date

    init(
        mood: String,
        genre: String,
        key: String,
        bpm: Int,
        theme: String,
        progression: String? = nil,
        trackName: String? = nil,
        artistName: String? = nil,
        artworkURL: String? = nil,
        previewURL: String? = nil,
        date: Date = .now
    ) {
        self.mood = mood
        self.genre = genre
        self.key = key
        self.bpm = bpm
        self.theme = theme
        self.progression = progression ?? KeyInfo.randomProgression(for: key)
        self.trackName = trackName
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.previewURL = previewURL
        self.date = date
    }

    // MARK: - Regeneration

    /// Regenerate everything — picks a new curated track, key/BPM come from the track
    func regenerateAll() {
        if let track = curatedTracks.randomTrack(mood: mood, genre: genre) {
            key = track.key
            bpm = track.bpm
            trackName = track.title
            artistName = track.artist
            artworkURL = nil
            previewURL = nil
            fetchiTunesData(query: track.itunesQuery)
        } else {
            // Fallback if no curated match
            key = allKeys.randomElement() ?? key
            bpm = randomBPM(for: mood)
        }
        theme = randomTheme(for: mood)
        progression = KeyInfo.randomProgression(for: key)
    }

    /// Regenerate only the chord progression
    func regenerateProgression() {
        progression = KeyInfo.randomProgression(for: key)
    }

    /// Regenerate only the theme
    func regenerateTheme() {
        theme = randomTheme(for: mood)
    }

    /// Fetch a new reference track (same mood + genre, keeps key/BPM)
    func fetchNewTrack() {
        guard let track = curatedTracks.randomTrack(mood: mood, genre: genre) else { return }
        trackName = track.title
        artistName = track.artist
        artworkURL = nil
        previewURL = nil
        fetchiTunesData(query: track.itunesQuery)
    }

    // MARK: - iTunes Fetch (artwork + preview only)

    private func fetchiTunesData(query: String) {
        let encoded = query
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let urlString = "https://itunes.apple.com/search?term=\(encoded)&media=music&limit=5"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                guard let self = self, let data = data, error == nil else { return }

                do {
                    let response = try JSONDecoder().decode(ITunesResponse.self, from: data)
                    if let match = response.results.first {
                        self.artworkURL = match.artworkUrl100
                        self.previewURL = match.previewUrl
                    }
                } catch {
                    print("iTunes parse error: \(error)")
                }
            }
        }.resume()
    }

    // MARK: - Helpers

    private func randomBPM(for mood: String) -> Int {
        let range = bpmRanges[mood] ?? 80...120
        return Int.random(in: range)
    }

    private func randomTheme(for mood: String) -> String {
        let moodThemes = themes[mood] ?? ["Let the music speak..."]
        return moodThemes.randomElement() ?? "Let the music speak..."
    }
}

// MARK: - Music Theory

struct KeyInfo {
    let name: String
    let notes: String

    static func info(for key: String) -> KeyInfo {
        let data: [String: String] = [
            "C Major":  "C - D - E - F - G - A - B",
            "C Minor":  "C - D - Eb - F - G - Ab - Bb",
            "C# Major": "C# - D# - E# - F# - G# - A# - B#",
            "C# Minor": "C# - D# - E - F# - G# - A - B",
            "D Major":  "D - E - F# - G - A - B - C#",
            "D Minor":  "D - E - F - G - A - Bb - C",
            "D# Major": "D# - E# - G - G# - A# - B# - D",
            "D# Minor": "D# - E# - F# - G# - A# - B - C#",
            "E Major":  "E - F# - G# - A - B - C# - D#",
            "E Minor":  "E - F# - G - A - B - C - D",
            "Eb Major": "Eb - F - G - Ab - Bb - C - D",
            "Eb Minor": "Eb - F - Gb - Ab - Bb - Cb - Db",
            "F Major":  "F - G - A - Bb - C - D - E",
            "F Minor":  "F - G - Ab - Bb - C - Db - Eb",
            "F# Major": "F# - G# - A# - B - C# - D# - E#",
            "F# Minor": "F# - G# - A - B - C# - D - E",
            "G Major":  "G - A - B - C - D - E - F#",
            "G Minor":  "G - A - Bb - C - D - Eb - F",
            "G# Major": "G# - A# - B# - C# - D# - E# - G",
            "G# Minor": "G# - A# - B - C# - D# - E - F#",
            "A Major":  "A - B - C# - D - E - F# - G#",
            "A Minor":  "A - B - C - D - E - F - G",
            "A# Major": "A# - B# - D - D# - F - G - A",
            "A# Minor": "A# - B# - C# - D# - F - F# - G#",
            "Ab Major": "Ab - Bb - C - Db - Eb - F - G",
            "Ab Minor": "Ab - Bb - Cb - Db - Eb - Fb - Gb",
            "B Major":  "B - C# - D# - E - F# - G# - A#",
            "B Minor":  "B - C# - D - E - F# - G - A",
            "Bb Major": "Bb - C - D - Eb - F - G - A",
            "Bb Minor": "Bb - C - Db - Eb - F - Gb - Ab",
            "Db Major": "Db - Eb - F - Gb - Ab - Bb - C",
        ]

        return KeyInfo(name: key, notes: data[key] ?? "—")
    }

    static func randomProgression(for key: String) -> String {
        let isMajor = key.contains("Major")

        let majorProgressions = [
            "I - V - vi - IV",
            "I - IV - V - I",
            "I - vi - IV - V",
            "I - IV - vi - V",
            "vi - IV - I - V",
            "I - V - IV - V",
            "I - iii - IV - V",
            "IV - V - I - vi",
            "I - IV - I - V",
            "I - V - vi - iii - IV",
        ]

        let minorProgressions = [
            "i - VI - III - VII",
            "i - iv - v - i",
            "i - VII - VI - VII",
            "i - iv - VII - III",
            "i - VI - iv - V",
            "i - III - VII - VI",
            "i - v - iv - i",
            "VI - VII - i - i",
            "i - iv - VI - V",
            "i - VII - VI - v",
        ]

        let list = isMajor ? majorProgressions : minorProgressions
        return list.randomElement() ?? "I - V - vi - IV"
    }
}
