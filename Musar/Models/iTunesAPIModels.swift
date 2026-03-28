//
//  iTunesAPIModels.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import Foundation

struct ITunesResponse: Codable {
    let results: [ITunesTrack]
}

struct ITunesTrack: Codable {
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let previewUrl: String?
}
