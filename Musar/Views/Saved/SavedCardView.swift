//
//  SavedCardView.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct SavedCardView: View {
    let session: SavedSession

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Mood + Label
            HStack(spacing: 6) {
                Image(systemName: "sparkle")
                    .font(.title3)
                Text("\(session.label) • \(session.mood) ")
                    .font(.title3.weight(.semibold))
            }
            .foregroundStyle(.seco0)

            // Key + BPM
            Text("\(session.key) · \(session.bpm) BPM")
                .font(.headline)
                .foregroundStyle(.seco10)
                .padding(.horizontal, 30)
                .padding(.top)

            // Theme preview
            Text(session.theme)
                .font(.body)
                .foregroundStyle(.seco10.opacity(0.6))
                .lineLimit(1)
                .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(28)
        .glassEffect(in: .rect(cornerRadius: 32.0))
        
    }
}

#Preview {
    VStack(spacing: 12) {
        SavedCardView(
            session: SavedSession(
                label: "Late night vibe",
                mood: "Melancholic",
                genre: "R&B",
                key: "E Major",
                bpm: 88,
                theme: "3am, driving alone, no destination...",
                progression: "I - V - vi - IV"
            )
        )
        SavedCardView(
            session: SavedSession(
                label: "Stargazing",
                mood: "Dreamy",
                genre: "Indie",
                key: "Bb Minor",
                bpm: 104,
                theme: "Late night under the stars...",
                progression: "i - VI - III - VII"
            )
        )
    }
    .padding()
}
