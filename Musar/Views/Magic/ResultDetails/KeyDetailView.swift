//
//  KeyDetailView.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct KeyDetailView: View {
    @ObservedObject var result: InspirationResult
    @Environment(\.dismiss) private var dismiss

    private var keyInfo: KeyInfo {
        KeyInfo.info(for: result.key)
    }
    
    
    //Background
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
            mainBCK
                .ignoresSafeArea()
                .onAppear {
                    start = path[0].0
                    end = path[0].1
                    animateNextLeg()
                }

            VStack(alignment: .leading, spacing: 0) {
                // Header
                    Text({
                        var s = AttributedString("Your key")
                        s.font = .system(size: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
                        if let range = s.range(of: "Your") {
                            s[range].foregroundColor = .seco10
                        }
                        if let range = s.range(of: "key") {
                            s[range].foregroundColor = .seco0
                        }
                        return s
                    }())
                .padding(.horizontal)
                .padding(.top, 16)

                // Subtitle
                Text("Try again to regenerate a chord progression.")
                    .font(.body)
                    .italic()
                    .foregroundStyle(.prim8)
                    .padding(.horizontal)
                    .padding(.top, 12)

                Spacer()

                // Key card
                VStack(spacing: 16) {
                    // Piano keyboard showing scale notes
                    PianoKeyboardView(scaleNotes: keyInfo.notes.components(separatedBy: " - "))
                        .frame(height: 170)
                        .padding(.horizontal, 20)

                    // Key name below keyboard
                    Text(keyInfo.name)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.seco10)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .glassEffect()

//                    // Progression card
//                    VStack(spacing: 8) {
//                        Text("Progression")
//                            .font(.headline)
//                            .foregroundStyle(.neut3)
//                        Text(result.progression)
//                            .font(.headline.weight(.semibold))
//                            .foregroundStyle(.neut0)
//                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
//                    .background(
//                        RoundedRectangle(cornerRadius: 16)
//                            .fill(Color.prim0)
//                    )
                }
                .padding(.horizontal, 40)
                
                

                Spacer()

                // Again = regenerate progression only
                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        result.regenerateProgression()
                    }
                } label: {
                    AgainButton()
                }
                .frame(maxWidth: .infinity)
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
        KeyDetailView(
            result: InspirationResult(
                mood: "Melancholic",
                genre: "R&B",
                key: "E Major",
                bpm: 110,
                theme: "3am, driving alone, no destination..."
            )
        )
    }
}
