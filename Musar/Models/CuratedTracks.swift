//
//  CuratedTracks.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import Foundation

struct CuratedTrack {
    let title: String
    let artist: String
    let key: String
    let bpm: Int
    let mood: String
    let genre: String
    let itunesQuery: String // precise search term to find this exact track
}

// MARK: - Curated Library

let curatedTracks: [CuratedTrack] = [

    //-----------------
    // EUPHORIC
    //-----------------

    CuratedTrack(title: "Blinding Lights", artist: "The Weeknd", key: "F Minor", bpm: 171, mood: "Euphoric", genre: "Pop", itunesQuery: "Blinding Lights The Weeknd"),
    CuratedTrack(title: "As It Was", artist: "Harry Styles", key: "F# Minor", bpm: 174, mood: "Euphoric", genre: "Pop", itunesQuery: "As It Was Harry Styles"),
    CuratedTrack(title: "HUMBLE.", artist: "Kendrick Lamar", key: "F# Minor", bpm: 150, mood: "Euphoric", genre: "Hip-Hop", itunesQuery: "HUMBLE Kendrick Lamar"),
    CuratedTrack(title: "Essence", artist: "Wizkid", key: "B Minor", bpm: 107, mood: "Euphoric", genre: "Afrobeats", itunesQuery: "Essence Wizkid"),
    CuratedTrack(title: "Levitating", artist: "Dua Lipa", key: "B Minor", bpm: 103, mood: "Euphoric", genre: "Pop", itunesQuery: "Levitating Dua Lipa"),
    CuratedTrack(title: "Best Part", artist: "Daniel Caesar", key: "G Major", bpm: 72, mood: "Euphoric", genre: "R&B", itunesQuery: "Best Part Daniel Caesar H.E.R."),
    CuratedTrack(title: "Electric Feel", artist: "MGMT", key: "E Minor", bpm: 120, mood: "Euphoric", genre: "Indie", itunesQuery: "Electric Feel MGMT"),
    CuratedTrack(title: "On Top of the World", artist: "Imagine Dragons", key: "B Major", bpm: 100, mood: "Euphoric", genre: "Rock", itunesQuery: "On Top of the World Imagine Dragons"),
    CuratedTrack(title: "Vivaldi Summer", artist: "Janine Jansen", key: "G Minor", bpm: 160, mood: "Euphoric", genre: "Classical", itunesQuery: "Summer Vivaldi Jansen"),
    CuratedTrack(title: "Got To Give It Up", artist: "Marvin Gaye", key: "A Major", bpm: 122, mood: "Euphoric", genre: "Soul", itunesQuery: "Got To Give It Up Marvin Gaye"),
    CuratedTrack(title: "Vivir Mi Vida", artist: "Marc Anthony", key: "A Minor", bpm: 126, mood: "Euphoric", genre: "Latin", itunesQuery: "Vivir Mi Vida Marc Anthony"),

    //-----------------
    // MELANCHOLIC
    //-----------------

    CuratedTrack(title: "Falling", artist: "Harry Styles", key: "Bb Minor", bpm: 74, mood: "Melancholic", genre: "Pop", itunesQuery: "Falling Harry Styles"),
    CuratedTrack(title: "The Night We Met", artist: "Lord Huron", key: "E Minor", bpm: 84, mood: "Melancholic", genre: "Indie", itunesQuery: "The Night We Met Lord Huron"),
    CuratedTrack(title: "Snooze", artist: "SZA", key: "Db Major", bpm: 143, mood: "Melancholic", genre: "R&B", itunesQuery: "Snooze SZA"),
    CuratedTrack(title: "Hurt", artist: "Johnny Cash", key: "A Minor", bpm: 74, mood: "Melancholic", genre: "Rock", itunesQuery: "Hurt Johnny Cash"),
    CuratedTrack(title: "Changes", artist: "Tupac", key: "C Major", bpm: 93, mood: "Melancholic", genre: "Hip-Hop", itunesQuery: "Changes Tupac"),
    CuratedTrack(title: "A Change Is Gonna Come", artist: "Sam Cooke", key: "Bb Major", bpm: 62, mood: "Melancholic", genre: "Soul", itunesQuery: "A Change Is Gonna Come Sam Cooke"),
    CuratedTrack(title: "Moonlight Sonata", artist: "Beethoven", key: "C# Minor", bpm: 60, mood: "Melancholic", genre: "Classical", itunesQuery: "Moonlight Sonata Beethoven"),
    CuratedTrack(title: "Last Goodbye", artist: "Burna Boy", key: "D Minor", bpm: 90, mood: "Melancholic", genre: "Afrobeats", itunesQuery: "Last Goodbye Burna Boy"),
    CuratedTrack(title: "La Llorona", artist: "Chavela Vargas", key: "E Minor", bpm: 78, mood: "Melancholic", genre: "Latin", itunesQuery: "La Llorona Chavela Vargas"),

    //-----------------
    // NOSTALGIC
    //-----------------

    CuratedTrack(title: "Flashing Lights", artist: "Kanye West", key: "Eb Minor", bpm: 103, mood: "Nostalgic", genre: "Hip-Hop", itunesQuery: "Flashing Lights Kanye West"),
    CuratedTrack(title: "Nights", artist: "Frank Ocean", key: "Db Major", bpm: 90, mood: "Nostalgic", genre: "R&B", itunesQuery: "Nights Frank Ocean"),
    CuratedTrack(title: "Dreams", artist: "Fleetwood Mac", key: "F Major", bpm: 120, mood: "Nostalgic", genre: "Rock", itunesQuery: "Dreams Fleetwood Mac"),
    CuratedTrack(title: "Cigarettes After Sex", artist: "Apocalypse", key: "E Major", bpm: 82, mood: "Nostalgic", genre: "Indie", itunesQuery: "Apocalypse Cigarettes After Sex"),
    CuratedTrack(title: "September", artist: "Earth Wind & Fire", key: "Ab Major", bpm: 126, mood: "Nostalgic", genre: "Soul", itunesQuery: "September Earth Wind Fire"),
    CuratedTrack(title: "Last Last", artist: "Burna Boy", key: "Ab Major", bpm: 107, mood: "Nostalgic", genre: "Afrobeats", itunesQuery: "Last Last Burna Boy"),
    CuratedTrack(title: "Teenage Dream", artist: "Katy Perry", key: "Eb Major", bpm: 120, mood: "Nostalgic", genre: "Pop", itunesQuery: "Teenage Dream Katy Perry"),
    CuratedTrack(title: "Besame Mucho", artist: "Andrea Bocelli", key: "D Minor", bpm: 108, mood: "Nostalgic", genre: "Latin", itunesQuery: "Besame Mucho Andrea Bocelli"),
    CuratedTrack(title: "Clair de Lune", artist: "Debussy", key: "Db Major", bpm: 66, mood: "Nostalgic", genre: "Classical", itunesQuery: "Clair de Lune Debussy"),

    //-----------------
    // ANGRY
    //-----------------

    CuratedTrack(title: "Killing in the Name", artist: "Rage Against the Machine", key: "D Minor", bpm: 82, mood: "Angry", genre: "Rock", itunesQuery: "Killing In The Name Rage Against Machine"),
    CuratedTrack(title: "DNA.", artist: "Kendrick Lamar", key: "G# Minor", bpm: 140, mood: "Angry", genre: "Hip-Hop", itunesQuery: "DNA Kendrick Lamar"),
    CuratedTrack(title: "Gasoline", artist: "The Weeknd", key: "F Minor", bpm: 160, mood: "Angry", genre: "Pop", itunesQuery: "Gasoline The Weeknd"),
    CuratedTrack(title: "No Church in the Wild", artist: "Jay-Z & Kanye West", key: "Bb Minor", bpm: 86, mood: "Angry", genre: "R&B", itunesQuery: "No Church in the Wild Jay-Z Kanye"),
    CuratedTrack(title: "Needed Me", artist: "Rihanna", key: "G# Minor", bpm: 109, mood: "Angry", genre: "R&B", itunesQuery: "Needed Me Rihanna"),
    CuratedTrack(title: "Mars", artist: "Holst", key: "C Minor", bpm: 130, mood: "Angry", genre: "Classical", itunesQuery: "Mars Planets Holst"),
    CuratedTrack(title: "Immigrant Song", artist: "Led Zeppelin", key: "F# Minor", bpm: 113, mood: "Angry", genre: "Rock", itunesQuery: "Immigrant Song Led Zeppelin"),

    //-----------------
    // DREAMY
    //-----------------

    CuratedTrack(title: "Thinkin Bout You", artist: "Frank Ocean", key: "D Major", bpm: 79, mood: "Dreamy", genre: "R&B", itunesQuery: "Thinkin Bout You Frank Ocean"),
    CuratedTrack(title: "Space Song", artist: "Beach House", key: "D Major", bpm: 86, mood: "Dreamy", genre: "Indie", itunesQuery: "Space Song Beach House"),
    CuratedTrack(title: "Gymnopédie No. 1", artist: "Erik Satie", key: "D Major", bpm: 66, mood: "Dreamy", genre: "Classical", itunesQuery: "Gymnopedie Satie"),
    CuratedTrack(title: "Kiss of Life", artist: "Sade", key: "D Minor", bpm: 92, mood: "Dreamy", genre: "Soul", itunesQuery: "Kiss of Life Sade"),
    CuratedTrack(title: "Slow Dancing in the Dark", artist: "Joji", key: "D Minor", bpm: 89, mood: "Dreamy", genre: "Pop", itunesQuery: "Slow Dancing in the Dark Joji"),
    CuratedTrack(title: "Location", artist: "Khalid", key: "Bb Major", bpm: 90, mood: "Dreamy", genre: "R&B", itunesQuery: "Location Khalid"),
    CuratedTrack(title: "Peru", artist: "Fireboy DML", key: "A Major", bpm: 105, mood: "Dreamy", genre: "Afrobeats", itunesQuery: "Peru Fireboy DML"),

    //-----------------
    // DARK
    //-----------------

    CuratedTrack(title: "Heartless", artist: "The Weeknd", key: "Eb Minor", bpm: 170, mood: "Dark", genre: "Pop", itunesQuery: "Heartless The Weeknd"),
    CuratedTrack(title: "m.A.A.d city", artist: "Kendrick Lamar", key: "F Minor", bpm: 146, mood: "Dark", genre: "Hip-Hop", itunesQuery: "maad city Kendrick Lamar"),
    CuratedTrack(title: "Creep", artist: "Radiohead", key: "G Major", bpm: 92, mood: "Dark", genre: "Rock", itunesQuery: "Creep Radiohead"),
    CuratedTrack(title: "In the Night", artist: "The Weeknd", key: "F Minor", bpm: 136, mood: "Dark", genre: "R&B", itunesQuery: "In the Night The Weeknd"),
    CuratedTrack(title: "Requiem Dies Irae", artist: "Mozart", key: "D Minor", bpm: 120, mood: "Dark", genre: "Classical", itunesQuery: "Dies Irae Mozart Requiem"),
    CuratedTrack(title: "Dusk Till Dawn", artist: "ZAYN", key: "Ab Minor", bpm: 120, mood: "Dark", genre: "Pop", itunesQuery: "Dusk Till Dawn ZAYN"),

    //-----------------
    // ROMANTIC
    //-----------------

    CuratedTrack(title: "At Last", artist: "Etta James", key: "F Major", bpm: 66, mood: "Romantic", genre: "Soul", itunesQuery: "At Last Etta James"),
    CuratedTrack(title: "Make You Feel My Love", artist: "Adele", key: "Bb Major", bpm: 76, mood: "Romantic", genre: "Pop", itunesQuery: "Make You Feel My Love Adele"),
    CuratedTrack(title: "Come Away with Me", artist: "Norah Jones", key: "C Major", bpm: 76, mood: "Romantic", genre: "Soul", itunesQuery: "Come Away with Me Norah Jones"),
    CuratedTrack(title: "Lover", artist: "Taylor Swift", key: "G Major", bpm: 68, mood: "Romantic", genre: "Pop", itunesQuery: "Lover Taylor Swift"),
    CuratedTrack(title: "Say You Won't Let Go", artist: "James Arthur", key: "Ab Major", bpm: 84, mood: "Romantic", genre: "Pop", itunesQuery: "Say You Won't Let Go James Arthur"),
    CuratedTrack(title: "Bésame Mucho", artist: "Luis Miguel", key: "D Minor", bpm: 100, mood: "Romantic", genre: "Latin", itunesQuery: "Besame Mucho Luis Miguel"),
    CuratedTrack(title: "Liebestraum", artist: "Liszt", key: "Ab Major", bpm: 58, mood: "Romantic", genre: "Classical", itunesQuery: "Liebestraum Liszt"),
    CuratedTrack(title: "Adorn", artist: "Miguel", key: "F# Minor", bpm: 80, mood: "Romantic", genre: "R&B", itunesQuery: "Adorn Miguel"),

    //-----------------
    // REBELLIOUS
    //-----------------

    CuratedTrack(title: "Smells Like Teen Spirit", artist: "Nirvana", key: "F Minor", bpm: 117, mood: "Rebellious", genre: "Rock", itunesQuery: "Smells Like Teen Spirit Nirvana"),
    CuratedTrack(title: "Alright", artist: "Kendrick Lamar", key: "F Minor", bpm: 112, mood: "Rebellious", genre: "Hip-Hop", itunesQuery: "Alright Kendrick Lamar"),
    CuratedTrack(title: "Born This Way", artist: "Lady Gaga", key: "F# Minor", bpm: 124, mood: "Rebellious", genre: "Pop", itunesQuery: "Born This Way Lady Gaga"),
    CuratedTrack(title: "Seven Nation Army", artist: "The White Stripes", key: "E Minor", bpm: 124, mood: "Rebellious", genre: "Rock", itunesQuery: "Seven Nation Army White Stripes"),
    CuratedTrack(title: "Ride of the Valkyries", artist: "Wagner", key: "B Minor", bpm: 100, mood: "Rebellious", genre: "Classical", itunesQuery: "Ride Valkyries Wagner"),
    CuratedTrack(title: "FE!N", artist: "Travis Scott", key: "C Minor", bpm: 150, mood: "Rebellious", genre: "Hip-Hop", itunesQuery: "FEIN Travis Scott"),

    //-----------------
    // CHAOTIC
    //-----------------

    CuratedTrack(title: "SICKO MODE", artist: "Travis Scott", key: "A Minor", bpm: 155, mood: "Chaotic", genre: "Hip-Hop", itunesQuery: "SICKO MODE Travis Scott"),
    CuratedTrack(title: "Bohemian Rhapsody", artist: "Queen", key: "Bb Major", bpm: 143, mood: "Chaotic", genre: "Rock", itunesQuery: "Bohemian Rhapsody Queen"),
    CuratedTrack(title: "Bad Guy", artist: "Billie Eilish", key: "G Minor", bpm: 135, mood: "Chaotic", genre: "Pop", itunesQuery: "Bad Guy Billie Eilish"),
    CuratedTrack(title: "XO Tour Llif3", artist: "Lil Uzi Vert", key: "A Minor", bpm: 155, mood: "Chaotic", genre: "Hip-Hop", itunesQuery: "XO Tour Llif3 Lil Uzi Vert"),
    CuratedTrack(title: "Flight of the Bumblebee", artist: "Rimsky-Korsakov", key: "A Minor", bpm: 160, mood: "Chaotic", genre: "Classical", itunesQuery: "Flight Bumblebee Rimsky-Korsakov"),
    CuratedTrack(title: "Lose Yourself", artist: "Eminem", key: "D Minor", bpm: 171, mood: "Chaotic", genre: "Hip-Hop", itunesQuery: "Lose Yourself Eminem"),
]

// MARK: - Lookup Helpers

extension Array where Element == CuratedTrack {

    /// Find tracks matching mood + genre
    func matching(mood: String, genre: String) -> [CuratedTrack] {
        self.filter { $0.mood == mood && $0.genre == genre }
    }

    /// Find tracks matching just the mood (fallback if no genre match)
    func matching(mood: String) -> [CuratedTrack] {
        self.filter { $0.mood == mood }
    }

    /// Pick a random track for a mood + genre combo, with fallback
    func randomTrack(mood: String, genre: String) -> CuratedTrack? {
        let exact = matching(mood: mood, genre: genre)
        if let track = exact.randomElement() { return track }

        // Fallback: any track in this mood
        let moodOnly = matching(mood: mood)
        return moodOnly.randomElement()
    }
}
