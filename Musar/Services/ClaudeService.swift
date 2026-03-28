//
//  ClaudeService.swift
//  Musar
//
//  Created by The Blue on 28/03/2026.
//

import Foundation

class ClaudeService {
    private let apiKey = Secrets.claudeAPIKey
    private let model = "claude-sonnet-4-20250514"
    private let endpoint = URL(string: "https://api.anthropic.com/v1/messages")!

    private let systemPrompt = """
        You are a music inspiration engine for an app called Musar. \
        A musician will describe how they feel or what they want to create. \
        Your job is to return structured musical direction based on their input.

        Return ONLY a JSON object with these exact fields, nothing else:
        {"mood":"","genre":"","key":"","bpm":0,"theme":"","itunesQuery":""}

        mood must be one of: Euphoric, Melancholic, Nostalgic, Angry, Dreamy, Dark, Romantic, Rebellious, Chaotic
        genre must be one of: Afrobeats, Soul, R&B, Pop, Hip-Hop, Indie, Latin, Rock, Classical
        key must be a musical key like E Minor or Bb Major
        bpm must be an integer between 60 and 180
        theme must be a short evocative phrase under 15 words that captures the feeling
        itunesQuery must be 3-4 words to search for a matching reference track on iTunes

        Rules:
        - The key, bpm, and genre must feel coherent with the mood
        - The theme should be poetic and specific, not generic
        - The itunesQuery should find a real song that matches the vibe
        - Return ONLY the raw JSON object, no markdown, no explanation, no backticks
        """

    func generate(from userInput: String) async throws -> WhisperResponse {
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")

        let requestBody = ClaudeRequest(
            model: model,
            max_tokens: 256,
            system: systemPrompt,
            messages: [
                ClaudeMessage(role: "user", content: userInput)
            ]
        )

        request.httpBody = try JSONEncoder().encode(requestBody)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ClaudeError.apiError(0)
        }

        guard httpResponse.statusCode == 200 else {
            // Print the error body for debugging
            if let errorBody = String(data: data, encoding: .utf8) {
                print("Claude API error \(httpResponse.statusCode): \(errorBody)")
            }
            throw ClaudeError.apiError(httpResponse.statusCode)
        }

        let apiResponse = try JSONDecoder().decode(ClaudeAPIResponse.self, from: data)

        guard let textContent = apiResponse.content.first(where: { $0.type == "text" }),
              let text = textContent.text else {
            throw ClaudeError.noContent
        }

        // Clean up response — remove markdown backticks if Claude adds them
        let cleaned = text
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let jsonData = cleaned.data(using: .utf8) else {
            throw ClaudeError.invalidJSON
        }

        let whisperResponse = try JSONDecoder().decode(WhisperResponse.self, from: jsonData)
        return whisperResponse
    }
}

// MARK: - Request Models

struct ClaudeRequest: Encodable {
    let model: String
    let max_tokens: Int
    let system: String
    let messages: [ClaudeMessage]
}

struct ClaudeMessage: Encodable {
    let role: String
    let content: String
}

// MARK: - Response Models

struct ClaudeAPIResponse: Codable {
    let content: [ClaudeContent]
}

struct ClaudeContent: Codable {
    let text: String?
    let type: String
}

struct WhisperResponse: Codable {
    let mood: String
    let genre: String
    let key: String
    let bpm: Int
    let theme: String
    let itunesQuery: String
}

// MARK: - Errors

enum ClaudeError: LocalizedError {
    case apiError(Int)
    case noContent
    case invalidJSON

    var errorDescription: String? {
        switch self {
        case .apiError(let code): return "API error (status \(code))"
        case .noContent: return "No response from Claude"
        case .invalidJSON: return "Couldn't parse the response"
        }
    }
}
