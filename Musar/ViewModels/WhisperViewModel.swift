//
//  WhisperViewModel.swift
//  Musar
//
//  Created by The Blue on 28/03/2026.
//

import SwiftUI
import Combine

class WhisperViewModel: ObservableObject {
    @Published var result: InspirationResult?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let claudeService = ClaudeService()

    /// Generate inspiration from Jeremy's freeform text
    func generate(from input: String) {
        guard !input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Tell me what you're feeling first."
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let response = try await claudeService.generate(from: input)

                await MainActor.run {
                    let newResult = InspirationResult(
                        mood: response.mood,
                        genre: response.genre,
                        key: response.key,
                        bpm: response.bpm,
                        theme: response.theme,
                        progression: KeyInfo.randomProgression(for: response.key)
                    )

                    result = newResult
                    isLoading = false

                    // Fetch reference track from iTunes
                    fetchiTunesData(for: newResult, query: response.itunesQuery)
                }
            } catch {
                await MainActor.run {
                    errorMessage = error.localizedDescription
                    isLoading = false
                }
            }
        }
    }

    // MARK: - iTunes Fetch

    private func fetchiTunesData(for result: InspirationResult, query: String) {
        let encoded = query
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let urlString = "https://itunes.apple.com/search?term=\(encoded)&media=music&limit=5"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else { return }

                do {
                    let response = try JSONDecoder().decode(ITunesResponse.self, from: data)
                    if let match = response.results.first {
                        result.trackName = match.trackName
                        result.artistName = match.artistName
                        result.artworkURL = match.artworkUrl100
                        result.previewURL = match.previewUrl
                    }
                } catch {
                    print("iTunes parse error: \(error)")
                }
            }
        }.resume()
    }
}
