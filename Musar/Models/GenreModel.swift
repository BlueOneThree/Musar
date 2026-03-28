//
//  GenreModel.swift
//  Musar
//
//  Created by The blue on 26/03/2026.
//

import Foundation

struct Genre {
    let name: String
    let descriptors: String
}

let allGenres: [Genre] = [
    Genre(name: "Afrobeats",  descriptors: "rhythmic · percussive · joyful"),
    Genre(name: "Soul",       descriptors: "warm · rich · deeply felt"),
    Genre(name: "R&B",        descriptors: "smooth · sensual · polished"),
    Genre(name: "Pop",        descriptors: "bright · catchy · polished"),
    Genre(name: "Hip-Hop",    descriptors: "raw · gritty · urban"),
    Genre(name: "Indie",      descriptors: "raw · lo-fi · heartfelt"),
    Genre(name: "Latin",      descriptors: "beat · rhythmic · passionate"),
    Genre(name: "Rock",       descriptors: "loud · raw · unfiltered"),
    Genre(name: "Classical",  descriptors: "elegant · structured · timeless"),
    Genre(name: "Random",     descriptors: "Surprise me")
]
