//
//  ThemeDetailView.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct ThemeDetailView: View {
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
    
    @ObservedObject var result: InspirationResult
    @Environment(\.dismiss) private var dismiss

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
                        var s = AttributedString("Your theme")
                        s.font = .system(size: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
                        if let range = s.range(of: "Your") {
                            s[range].foregroundColor = .seco10
                        }
                        if let range = s.range(of: "theme") {
                            s[range].foregroundColor = .seco0
                        }
                        return s
                    }())
                .padding(.horizontal)
                .padding(.top, 16)

                // Subtitle
                Text("Try again to regenerate a theme.")
                    .font(.body)
                    .italic()
                    .foregroundStyle(.prim8)
                    .padding(.horizontal)
                    .padding(.top, 12)

                Spacer()

                // Theme card
                VStack(alignment: .leading, spacing: 8) {
                    Text(result.theme)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.seco10)
                        .lineSpacing(6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .fill(Color.seco10.opacity(0.05))
                )
                .padding(.horizontal)

                Spacer()
                
                // Again = regenerate theme only
                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        result.regenerateTheme()
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
        ThemeDetailView(
            result: InspirationResult(
                mood: "Melancholic",
                genre: "R&B",
                key: "E Major",
                bpm: 110,
                theme: "3am, driving alone with no destination, the city asleep while your thoughts wander louder than the road ahead."
            )
        )
    }
}
