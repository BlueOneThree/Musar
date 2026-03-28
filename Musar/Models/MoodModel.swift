//
//  MoodModel.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import Foundation

struct Mood {
    let name: String
    let descriptors: String
}

let allMoods: [Mood] = [
    Mood(name: "Euphoric",     descriptors: "fast · major · bright"),
    Mood(name: "Melancholic",  descriptors: "slow · minor · raw"),
    Mood(name: "Nostalgic",    descriptors: "warm · hazy · aching"),
    Mood(name: "Angry",        descriptors: "hard · loud · distorted"),
    Mood(name: "Dreamy",       descriptors: "ambient · soft · hazy"),
    Mood(name: "Dark",         descriptors: "cold · cinematic · heavy"),
    Mood(name: "Romantic",     descriptors: "lush · tender · swelling"),
    Mood(name: "Rebellious",   descriptors: "raw · electric · defiant"),
    Mood(name: "Chaotic",      descriptors: "glitchy · unpredictable · wild"),
    Mood(name: "Random",       descriptors: "Surprise me")
]
