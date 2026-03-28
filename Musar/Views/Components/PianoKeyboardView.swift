//
//  PianoKeyboardView.swift
//  Musar
//
//  Created by The Blue on 28/03/2026.
//

import SwiftUI

struct PianoKeyboardView: View {
    let scaleNotes: [String]

    private let whiteKeys = ["C", "D", "E", "F", "G", "A", "B"]

    // Each black key: (note name, index of white key it sits after)
    // C# between C(0) and D(1), D# between D(1) and E(2),
    // F# between F(3) and G(4), G# between G(4) and A(5), A# between A(5) and B(6)
    private let blackKeys: [(note: String, afterIndex: Int)] = [
        ("C#", 0), ("D#", 1), ("F#", 3), ("G#", 4), ("A#", 5)
    ]

    private let enharmonics: [String: String] = [
        "Db": "C#", "Eb": "D#", "Fb": "E", "Gb": "F#",
        "Ab": "G#", "Bb": "A#", "Cb": "B",
        "E#": "F", "B#": "C",
    ]

    private let whiteKeyWidth: CGFloat = 42
    private let whiteKeyHeight: CGFloat = 160
    private let whiteKeySpacing: CGFloat = 3
    private let blackKeyWidth: CGFloat = 28
    private let blackKeyHeight: CGFloat = 100

    @State private var glowPhase = false

    var body: some View {
        let totalWidth = CGFloat(whiteKeys.count) * whiteKeyWidth + CGFloat(whiteKeys.count - 1) * whiteKeySpacing

        ZStack(alignment: .topLeading) {
            // White keys
            HStack(spacing: whiteKeySpacing) {
                ForEach(whiteKeys, id: \.self) { note in
                    WhiteKey(
                        note: note,
                        isActive: isNoteInScale(note),
                        glowPhase: glowPhase
                    )
                    .frame(width: whiteKeyWidth, height: whiteKeyHeight)
                }
            }

            // Black keys — positioned precisely
            ForEach(blackKeys, id: \.note) { black in
                let xPos = CGFloat(black.afterIndex) * (whiteKeyWidth + whiteKeySpacing) + whiteKeyWidth - blackKeyWidth / 2 + whiteKeySpacing / 2

                BlackKey(
                    note: black.note,
                    isActive: isNoteInScale(black.note),
                    glowPhase: glowPhase
                )
                .frame(width: blackKeyWidth, height: blackKeyHeight)
                .offset(x: xPos)
            }
        }
        .frame(width: totalWidth, height: whiteKeyHeight)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                glowPhase = true
            }
        }
    }

    private func isNoteInScale(_ note: String) -> Bool {
        let normalized = normalizeNote(note)
        return scaleNotes.contains { normalizeNote($0) == normalized }
    }

    private func normalizeNote(_ note: String) -> String {
        let clean = note.filter { !$0.isNumber }
        return enharmonics[clean] ?? clean
    }
}

// MARK: - White Key

struct WhiteKey: View {
    let note: String
    let isActive: Bool
    let glowPhase: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 6)
                .fill(isActive ? Color.prim0.opacity(glowPhase ? 0.25 : 0.12) : Color.neut0)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(
                            isActive ? Color.prim0.opacity(glowPhase ? 0.6 : 0.3) : Color.neut5.opacity(0.3),
                            lineWidth: isActive ? 1.5 : 0.5
                        )
                )
                .shadow(color: isActive ? Color.prim0.opacity(glowPhase ? 0.4 : 0.1) : .clear, radius: isActive ? 8 : 0)

            Text(note)
                .font(.system(size: 11, weight: isActive ? .bold : .regular))
                .foregroundStyle(isActive ? .prim0 : .neut5)
                .padding(.bottom, 8)
        }
    }
}

// MARK: - Black Key

struct BlackKey: View {
    let note: String
    let isActive: Bool
    let glowPhase: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 4)
                .fill(isActive ? Color.prim0.opacity(glowPhase ? 0.9 : 0.7) : Color.seco10)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(
                            isActive ? Color.prim0.opacity(glowPhase ? 0.8 : 0.4) : .clear,
                            lineWidth: 1
                        )
                )
                .shadow(color: isActive ? Color.prim0.opacity(glowPhase ? 0.6 : 0.2) : .clear, radius: isActive ? 10 : 0)

            Text(note)
                .font(.system(size: 9, weight: isActive ? .bold : .regular))
                .foregroundStyle(isActive ? .white : .neut5)
                .padding(.bottom, 6)
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        // E Major: E - F# - G# - A - B - C# - D#
        VStack(spacing: 8) {
            Text("E Major")
                .font(.headline)
            PianoKeyboardView(scaleNotes: ["E", "F#", "G#", "A", "B", "C#", "D#"])
        }

        // A Minor: A - B - C - D - E - F - G
        VStack(spacing: 8) {
            Text("A Minor")
                .font(.headline)
            PianoKeyboardView(scaleNotes: ["A", "B", "C", "D", "E", "F", "G"])
        }
    }
    .padding()
}
