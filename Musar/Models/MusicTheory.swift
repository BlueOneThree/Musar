//
//  MusicTheory.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import Foundation

// MARK: - Musical Keys

let allKeys: [String] = [
    "C Major", "C Minor","C# Major", "C# Minor",
    "D Major", "D Minor","D# Major", "D# Minor",
    "E Major", "E Minor",
    "F Major", "F Minor","F# Major", "F# Minor",
    "G Major", "G Minor","G# Major", "G# Minor",
    "A Major", "A Minor","A# Major", "A# Minor",
    "B Major", "B Minor"
]

// MARK: - BPM Ranges (by mood)

let bpmRanges: [String: ClosedRange<Int>] = [
    "Euphoric":    120...145,
    "Melancholic": 70...100,
    "Nostalgic":   85...110,
    "Angry":       130...160,
    "Dreamy":      60...90,
    "Dark":        80...110,
    "Romantic":    75...105,
    "Rebellious":  130...155,
    "Chaotic":     140...180,
]
