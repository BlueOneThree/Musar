//
//  InspirationViewModel.swift
//  Musar
//
//  Created by FUVE on 26/03/2026.
//

import SwiftUI
import Combine

class InspirationViewModel: ObservableObject {
    @Published var result: InspirationResult?
    @Published var isLoading = false

    /// Generate a full inspiration result from mood + genre
    func generate(mood: String?, genre: String?) {
        let resolvedMood = resolveMood(mood)
        let resolvedGenre = resolveGenre(genre)

        // 1. Pick a curated track — this drives the key and BPM
        guard let track = curatedTracks.randomTrack(mood: resolvedMood, genre: resolvedGenre) else {
            // Fallback if somehow no match
            generateFallback(mood: resolvedMood, genre: resolvedGenre)
            return
        }

        // 2. Use the track's key and BPM
        let theme = randomTheme(for: resolvedMood)
        let progression = KeyInfo.randomProgression(for: track.key)

        // 3. Build result with track info
        let newResult = InspirationResult(
            mood: resolvedMood,
            genre: resolvedGenre,
            key: track.key,
            bpm: track.bpm,
            theme: theme,
            progression: progression,
            trackName: track.title,
            artistName: track.artist
        )

        result = newResult

        // 4. Fetch artwork and preview URL from iTunes
        fetchiTunesData(for: newResult, query: track.itunesQuery)
    }

    // MARK: - iTunes Fetch (artwork + preview only)

    private func fetchiTunesData(for result: InspirationResult, query: String) {
        isLoading = true

        let encoded = query
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let urlString = "https://itunes.apple.com/search?term=\(encoded)&media=music&limit=5"

        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                self?.isLoading = false

                guard let data = data, error == nil else { return }

                do {
                    let response = try JSONDecoder().decode(ITunesResponse.self, from: data)
                    if let match = response.results.first {
                        result.artworkURL = match.artworkUrl100
                        result.previewURL = match.previewUrl
                    }
                } catch {
                    print("iTunes parse error: \(error)")
                }
            }
        }.resume()
    }

    // MARK: - Fetch New Reference Track (for "Again" on ReferenceDetailView)

    func fetchNewTrack(for result: InspirationResult) {
        // Pick a different curated track in the same mood + genre
        guard let track = curatedTracks.randomTrack(mood: result.mood, genre: result.genre) else { return }

        result.trackName = track.title
        result.artistName = track.artist
        // Key and BPM stay the same — only the reference changes

        fetchiTunesData(for: result, query: track.itunesQuery)
    }

    // MARK: - Fallback (no curated match)

    private func generateFallback(mood: String, genre: String) {
        let key = allKeys.randomElement() ?? "C Major"
        let range = bpmRanges[mood] ?? 80...120
        let bpm = Int.random(in: range)
        let theme = randomTheme(for: mood)
        let progression = KeyInfo.randomProgression(for: key)

        result = InspirationResult(
            mood: mood,
            genre: genre,
            key: key,
            bpm: bpm,
            theme: theme,
            progression: progression
        )
    }

    // MARK: - Helpers

    private func randomTheme(for mood: String) -> String {
        let moodThemes = themes[mood] ?? ["Let the music speak..."]
        return moodThemes.randomElement() ?? "Let the music speak..."
    }

    private func resolveMood(_ mood: String?) -> String {
        guard let mood = mood, mood != "Random" else {
            let moods = ["Euphoric", "Melancholic", "Nostalgic", "Angry",
                         "Dreamy", "Dark", "Romantic", "Rebellious", "Chaotic"]
            return moods.randomElement() ?? "Euphoric"
        }
        return mood
    }

    private func resolveGenre(_ genre: String?) -> String {
        guard let genre = genre, genre != "Random" else {
            let genres = ["Afrobeats", "Soul", "R&B", "Pop",
                          "Hip-Hop", "Indie", "Latin", "Rock", "Classical"]
            return genres.randomElement() ?? "Pop"
        }
        return genre
    }
}
