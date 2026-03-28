//
//  ReferenceDetailView.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI
import AVFoundation

struct ReferenceDetailView: View {
    @ObservedObject var result: InspirationResult

    @Environment(\.dismiss) private var dismiss
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 30
    @State private var timer: Timer?
    
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

    var body: some View {
        ZStack {
            // Gradient background
            mainBCK
                .ignoresSafeArea()
                .onAppear {
                    start = path[0].0
                    end = path[0].1
                    animateNextLeg()
                }

            VStack(spacing: 0) {
                // Header
                    Text({
                        var s = AttributedString("Your reference")
                        s.font = .system(size: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
                        if let range = s.range(of: "Your") {
                            s[range].foregroundColor = .seco10
                        }
                        if let range = s.range(of: "reference") {
                            s[range].foregroundColor = .seco0
                        }
                        return s
                    }())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 16)
                
                Text("Try again to regenerate a new song.")
                    .font(.body)
                    .italic()
                    .foregroundStyle(.prim8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 12)

                Spacer()

                // Album artwork
                if let artworkURL = result.artworkURL,
                   let url = URL(string: artworkURL.replacingOccurrences(of: "100x100", with: "600x600")) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.1))
                    }
                    .frame(width: 260, height: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.3), radius: 20, y: 10)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 260, height: 260)
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.system(size: 60))
                                .foregroundStyle(.white.opacity(0.3))
                        )
                }

                // Track info
                VStack(spacing: 4) {
                    Text(result.artistName ?? "Unknown Artist")
                        .font(.title3)
                        .foregroundStyle(.seco10.opacity(0.7))
                    Text(result.trackName ?? "Unknown Track")
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.seco10)
                }
                .padding(.top, 24)

                // Progress bar
                VStack(spacing: 4) {
                    Slider(value: $currentTime, in: 0...duration)
                        .tint(.seco10)
                        .onAppear {
                               UISlider.appearance().setThumbImage(UIImage(), for: .normal)
                           }
                        .onDisappear {
                            UISlider.appearance().setThumbImage(nil, for: .normal)
                        }

                    HStack {
                        Text(formatTime(currentTime))
                            .font(.system(size: 11))
                            .foregroundStyle(.seco10)
                        Spacer()
                        Text(formatTime(duration))
                            .font(.system(size: 11))
                            .foregroundStyle(.seco10)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)

                Spacer()

                // Playback controls
                HStack(spacing: 24) {
                    // Again = fetch new reference track
                    Button {
                        stopAudio()
                        currentTime = 0
                        result.fetchNewTrack()
                        // TODO: Call iTunesService to fetch a new track
                        // For now, just reset playback state
                    } label: {
                        AgainButton()
                    }

                    // Play/Pause button
                    Button {
                        togglePlayback()
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(.body)
                            Text(isPlaying ? "Pause" : "Play")
                                .font(.body)
                        }
                        .foregroundStyle(.seco0)
                        .frame(width: 170, height: 56)
                        .background(.clear)
                        .glassEffect(.clear)
                    }
                }
                .padding(.bottom, 24)
            }
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
        .onDisappear {
            stopAudio()
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

    // MARK: - Audio Playback

    private func togglePlayback() {
        if isPlaying {
            player?.pause()
            timer?.invalidate()
            isPlaying = false
        } else {
            if player == nil, let previewURL = result.previewURL,
               let url = URL(string: previewURL) {
                player = AVPlayer(url: url)
            }
            player?.play()
            isPlaying = true
            startTimer()
        }
    }

    private func stopAudio() {
        player?.pause()
        player = nil
        timer?.invalidate()
        isPlaying = false
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if let currentItem = player?.currentItem {
                let time = CMTimeGetSeconds(currentItem.currentTime())
                let dur = CMTimeGetSeconds(currentItem.duration)
                if time.isFinite { currentTime = time }
                if dur.isFinite { duration = dur }
            }
        }
    }

    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview {
    NavigationStack {
        ReferenceDetailView(
            result: InspirationResult(
                mood: "Melancholic",
                genre: "R&B",
                key: "E Major",
                bpm: 110,
                theme: "3am, driving alone, no destination...",
                trackName: "Falling",
                artistName: "Harry Styles"
            )
        )
    }
}
