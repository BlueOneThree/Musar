//
//  ResultView.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct InspirationResultView: View {
    @ObservedObject var result: InspirationResult
    var onSave: (String) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSaveAlert = false
    @State private var sessionLabel = ""
    
    @State private var savedSessionID: UUID?
    var isSaved: Bool {
        savedSessionID != nil
    }
    @State private var showDeleteAlert = false


    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                    // Your inspiration
                    Text({
                        var s = AttributedString("Your inspiration")
                        s.font = .system(size: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
                        if let range = s.range(of: "Your") {
                            s[range].foregroundColor = .seco10
                        }
                        if let range = s.range(of: "inspiration") {
                            s[range].foregroundColor = .seco0
                        }
                        return s
                    }())
                .padding(.horizontal)
                .padding(.top, 16)

                ScrollView(showsIndicators: false) {
                    // Main card
                    VStack(alignment: .leading, spacing: 16) {

                        // Mood badge
                        HStack(spacing: 6) {
                            Image(systemName: "sparkle")
                                .font(.title3)
                            Text(result.mood)
                                .font(.title3.weight(.semibold))
                        }
                        .foregroundStyle(.prim0)
                        .frame(maxWidth: .infinity)

                        // Key + BPM row
                        HStack(spacing: 16) {
                            NavigationLink {
                                KeyDetailView(result: result)
                            } label: {
                                VStack(spacing: 24) {
                                    Text("Key")
                                        .font(.headline)
                                        .foregroundStyle(.neut2)
                                    Text(result.key)
                                        .font(.title2.weight(.semibold))
                                        .foregroundStyle(.neut0)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.prim0)
                                )
                            }

                            VStack(spacing: 24) {
                                Text("BPM")
                                    .font(.headline)
                                    .foregroundStyle(.neut2)
                                Text("\(result.bpm)")
                                    .font(.title2.weight(.semibold))
                                    .foregroundStyle(.neut0)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.prim0)
                            )
                        }.frame(maxWidth: .infinity, alignment: .center)

                        // Theme card
                        NavigationLink {
                            ThemeDetailView(result: result)
                        } label: {
                            VStack(alignment: .leading, spacing: 24) {
                                Text("Theme")
                                    .font(.headline)
                                    .foregroundStyle(.neut2)
                                Text(result.theme)
                                    .font(.title2.weight(.semibold))
                                    .foregroundStyle(.neut0)
                                    .multilineTextAlignment(.leading)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.prim0)
                            )
                        }.frame(maxWidth: .infinity, alignment: .center)

                        // Reference track card
                        if let trackName = result.trackName,
                           let artistName = result.artistName {
                            NavigationLink {
                                ReferenceDetailView(result: result)
                            } label: {
                                HStack(spacing: 12) {
                                    if let artworkURL = result.artworkURL,
                                       let url = URL(string: artworkURL) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.prim0.opacity(0.5))
                                        }
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(artistName)
                                            .font(.headline)
                                            .foregroundStyle(.neut2)
                                        Text(trackName)
                                            .font(.title2.weight(.semibold))
                                            .foregroundStyle(.neut0)
                                    }

                                    Spacer()

                                    Image(systemName: "play.circle.fill")
                                        .font(.system(size: 28))
                                        .foregroundStyle(.neut0)
                                }
                                .padding(12)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.prim0)
                                )
                            }.frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding(32)
                    .background(
                        RoundedRectangle(cornerRadius: 32)
                            .fill(Color.seco10.opacity(0.05))
                    )
                    .padding(.horizontal)
                    .padding(.top, 32)
                }

                // Bottom action buttons
                HStack(spacing: 12) {
                    Button {
                        withAnimation(.easeOut(duration: 0.2)) {
                            result.regenerateAll()
                        }
                        // TODO: Also fetch new reference track via iTunesService
                    } label: {
                        AgainButton()
                    }

                    Button {
                        sessionLabel = ""
                        showSaveAlert = true
                    } label: {
                        SaveButton()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
                .padding(.bottom, 52)
            }
            
        }
        // Background
        .animatedBackground()
        
        .alert("Name your session", isPresented: $showSaveAlert) {
            TextField("e.g. Late night vibe", text: $sessionLabel)
            Button("Save") {
                onSave(sessionLabel.isEmpty ? "\(result.mood) session" : sessionLabel)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Give it a name so you can find it later.")
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

#Preview {
    NavigationStack {
        InspirationResultView(
            result: InspirationResult(
                mood: "Melancholic",
                genre: "R&B",
                key: "E Major",
                bpm: 110,
                theme: "3am, driving alone, no destination...",
                trackName: "Falling",
                artistName: "Harry Styles"
            ),
            onSave: { _ in }
        )
    }
}
