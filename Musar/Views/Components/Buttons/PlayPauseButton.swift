//
//  PlayPauseButton.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI
import AVFoundation

struct PlayPauseButton: View {
    @ObservedObject var result: InspirationResult

    @Environment(\.dismiss) private var dismiss
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 30
    @State private var timer: Timer?
    
    var body: some View {
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
    PlayPauseButton(result: InspirationResult(
        mood: "Melancholic",
        genre: "R&B",
        key: "E Major",
        bpm: 110,
        theme: "3am, driving alone, no destination...",
        trackName: "Falling",
        artistName: "Harry Styles"
    ))
}
