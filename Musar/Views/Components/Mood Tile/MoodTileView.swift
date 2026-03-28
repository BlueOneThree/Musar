//
//  MoodTileView.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

// Use this to display any mood tile by name
// Example: MoodTileView(mood: "Euphoric")

struct MoodTileView: View {
    let mood: String

    var body: some View {
        Group {
            switch mood {
            case "Euphoric":    EuphoricTile()
            case "Melancholic": MelancholicTile()
            case "Nostalgic":   NostalgicTile()
            case "Angry":       AngryTile()
            case "Dreamy":      DreamyTile()
            case "Dark":        DarkTile()
            case "Romantic":    RomanticTile()
            case "Rebellious":  RebelliousTile()
            case "Chaotic":     ChaoticTile()
            case "Random":      RandomMoodTile()
            default:            RandomMoodTile()
            }
        }
        .frame(width: 160, height: 190)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Usage in a grid

import SwiftUI

struct MoodGridView: View {
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
    
    @Binding var selectedMood: String?
    @Environment(\.dismiss) private var dismiss

    let moods = [
        "Euphoric", "Melancholic", "Nostalgic",
        "Angry", "Dreamy", "Dark",
        "Romantic", "Rebellious", "Chaotic", "Random"
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
                    Text("PICK A MOOD")
                        .font(.headline)
                        .italic()
                        .foregroundStyle(.prim10)
                    
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(moods, id: \.self) { mood in
                            MoodTileView(mood: mood)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            Color.seco0,
                                            lineWidth: selectedMood == mood ? 4 : 0
                                        ).blur(radius: 2)
                                )
                                .scaleEffect(selectedMood == mood ? 0.96 : 1.0)
                                .animation(.easeOut(duration: 0.15), value: selectedMood)
                                .onTapGesture {
                                    withAnimation(.easeOut(duration: 0.15)) {
                                        selectedMood = mood
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
        MoodGridView(selectedMood: .constant("Euphoric"))
    }
}
