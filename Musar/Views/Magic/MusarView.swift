//
//  MagicView.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI
import SwiftData

struct MusarView: View {
    @Query private var sessions: [SavedSession]
    
    @Environment(\.modelContext) private var modelContext
    @State private var savedViewModel = SavedViewModel()
    @State private var showSaveAlert = false
    @State private var sessionLabel = ""
    
    @StateObject private var viewModel = InspirationViewModel()
    
    @State private var showResult = false

    // Selection state
    @State private var selectedMood: String? = nil
    @State private var selectedGenre: String? = nil
    @State private var showSelectionAlert = false

    // Default previews
    private let defaultMoods = ["Euphoric", "Melancholic", "Nostalgic"]
    private let defaultGenres = ["Afrobeats", "Soul", "R&B"]

    // Reordered: selected tile first, always visible
    var visibleMoods: [String] {
        guard let selected = selectedMood else { return defaultMoods }
        if defaultMoods.contains(selected) {
            return [selected] + defaultMoods.filter { $0 != selected }
        } else {
            return [selected] + defaultMoods
        }
    }

    var visibleGenres: [String] {
        guard let selected = selectedGenre else { return defaultGenres }
        if defaultGenres.contains(selected) {
            return [selected] + defaultGenres.filter { $0 != selected }
        } else {
            return [selected] + defaultGenres
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text({
                        var s = AttributedString("What's the vibe ?")
                        s.font = .system(size: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
                        if let range = s.range(of: "vibe") {
                            s[range].foregroundColor = .seco0
                        }
                        if let range = s.range(of: "What's the") {
                            s[range].foregroundColor = .seco10
                        }
                        if let range = s.range(of: "?") {
                            s[range].foregroundColor = .seco10
                        }
                        return s
                    }())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical)

                    ScrollView(showsIndicators: false){
                        // PICK A MOOD
                        HStack {
                            Text("PICK A MOOD")
                                .font(.headline)
                                .italic()
                                .foregroundStyle(.prim10)
                            Spacer()
                            NavigationLink {
                                MoodGridView(selectedMood: $selectedMood)
                            } label: {
                                Text("See all")
                                    .font(.footnote)
                                    .foregroundStyle(.seco0)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical)

                        // MOOD TILE
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(visibleMoods, id: \.self) { mood in
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
                                                selectedMood = selectedMood == mood ? nil : mood
                                            }
                                        }
                                }
                            }
                            .animation(.easeOut(duration: 1), value: visibleMoods)
                            .padding(.horizontal)
                        }

                        // SELECT A GENRE
                        HStack {
                            Text("SELECT A GENRE")
                                .font(.headline)
                                .italic()
                                .foregroundStyle(.prim10)
                            Spacer()
                            NavigationLink {
                                GenreGridView(selectedGenre: $selectedGenre)
                            } label: {
                                Text("See all")
                                    .font(.footnote)
                                    .foregroundStyle(.seco0)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical)

                        // GENRE TILE
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(visibleGenres, id: \.self) { genre in
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
                                                selectedGenre = selectedGenre == genre ? nil : genre
                                            }
                                        }
                                }
                            }
                            .animation(.easeOut(duration: 1), value: visibleGenres)
                            .padding(.horizontal)
                        }

                        // BUTTONS
                        HStack {
                            
                            // Magic
                            Button {
                                if selectedMood == nil || selectedGenre == nil {
                                    showSelectionAlert = true
                                } else {
                                    viewModel.generate(mood: selectedMood, genre: selectedGenre)
                                    showResult = true
                                }
                            } label: {
                                MagicButton()
                            }
                            
                            // Whisper
                            NavigationLink {
                                WhisperView()
                            } label: {
                                WhisperButton()
                            }
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .center)

                    } // ScrollView
                } // VStack
            } // ZStack
            
            // Background
            .animatedBackground()
            
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $showResult) {
                if let result = viewModel.result {
                    InspirationResultView(
                        result: result,
                        onSave: { label in
                            savedViewModel.save(result, label: label, context: modelContext)
                            showResult = false
                        }
                    )
                }
            }
            .alert("Hold on!", isPresented: $showSelectionAlert) {
                Button("Got it", role: .cancel) { }
            } message: {
                Text("Pick a mood and a genre before generating.")
            }
        } // NavigationStack
    }
}

#Preview {
    MusarView()
}
