//
//  GenreTileView.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

// Use this to display any genre tile by name
// Example: GenreTileView(genre: "Afrobeats")

struct GenreTileView: View {
    let genre: String

    var body: some View {
        Group {
            switch genre {
            case "Afrobeats":  AfrobeatsTile()
            case "Soul":       SoulTile()
            case "R&B":        RnBTile()
            case "Pop":        PopTile()
            case "Hip-Hop":    HipHopTile()
            case "Indie":      IndieTile()
            case "Latin":      LatinTile()
            case "Rock":       RockTile()
            case "Classical":  ClassicalTile()
            case "Random":     GenreRandomTile()
            default:           GenreRandomTile()
            }
        }
        .frame(width: 160, height: 190)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Usage in a grid

import SwiftUI

struct GenreGridView: View {
    @State private var start: UnitPoint = .topLeading
    @State private var end: UnitPoint = .bottomTrailing
    @State private var legIndex: Int = 0
    
    private let path: [(UnitPoint, UnitPoint)] = [
        (.topLeading, .bottomTrailing),
        (.topTrailing, .bottomLeading),
        (.bottomTrailing, .topLeading),
        (.bottomLeading, .topTrailing)
    ]

    var mainBCK: LinearGradient {
        LinearGradient(colors: [.neut0, .seco2], startPoint: start, endPoint: end)
    }
    
    @Binding var selectedGenre: String?
    @Environment(\.dismiss) private var dismiss

    let genres = [
        "Afrobeats", "Soul", "R&B", "Pop",
        "Hip-Hop", "Indie", "Latin", "Rock",
        "Classical", "Random"
    ]

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        ZStack {
            mainBCK
                .ignoresSafeArea()
                .onAppear {
                    start = path[0].0
                    end = path[0].1
                    animateNextLeg()
                }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("SELECT A GENRE")
                        .font(.headline)
                        .italic()
                        .foregroundStyle(.prim10)
                    
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(genres, id: \.self) { genre in
                            GenreTileView(genre: genre)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            Color.seco0,
                                            lineWidth: selectedGenre == genre ? 4 : 0
                                        ).blur(radius: 2)
                                )
                                .scaleEffect(selectedGenre == genre ? 0.96 : 1.0)
                                .animation(.easeOut(duration: 0.15), value: selectedGenre)
                                .onTapGesture {
                                    withAnimation(.easeOut(duration: 0.15)) {
                                        selectedGenre = genre
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        dismiss()
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.seco10)
                    }
                }
            }
        }
    }
    private func animateNextLeg() {
        let next = (legIndex + 1) % path.count
        withAnimation(.easeInOut(duration: 10)) {
            start = path[next].0
            end = path[next].1
        }
        legIndex = next
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            animateNextLeg()
        }
    }
}

#Preview {
    NavigationStack {
        GenreGridView(selectedGenre: .constant("Soul"))
    }
}
