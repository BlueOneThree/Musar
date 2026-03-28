//
//  OnboardingSlide2.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct OnboardingSlide2: View {
    // Background
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
        LinearGradient(colors: [.seco10, .seco0], startPoint: start, endPoint: end)
    }
    
    @Binding var currentPage: Int

    var body: some View {
        ZStack {
            // Blue gradient background
            mainBCK
                .ignoresSafeArea()
                .onAppear {
                    start = path[0].0
                    end = path[0].1
                    animateNextLeg()
                }

            VStack(spacing: 0) {
                // Page indicator
                HStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.neut0.opacity(0.3))
                        .frame(width: 40, height: 4)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.neut0)
                        .frame(width: 40, height: 4)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.neut0.opacity(0.3))
                        .frame(width: 40, height: 4)
                }
                .padding(.top, 60)

                Spacer()

                // Icon
                ZStack {
                    Image(systemName: "star")
                        .font(.largeTitle)
                        .foregroundStyle(.seco0)
                        .frame(width: 80, height: 80)
                        .glassEffect(.clear)
                }

                Spacer()
                    .frame(height: 60)

                // Text content
                VStack(spacing: 16) {
                    Text("Pick a mood.\nGet a spark.")
                        .font(.title.weight(.semibold))
                        .foregroundStyle(.neut0)
                        .multilineTextAlignment(.center)

                    Text("Musar gives you a direction — \nkey, tempo, theme, reference track.\nYour song, your way.")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }

                Spacer()

                // Next button
                Button {
                    withAnimation(.easeOut(duration: 0.3)) {
                        currentPage = 2
                    }
                } label: {
                    Text("Next")
                        .font(.title3)
                        .foregroundStyle(.neut0)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .glassEffect(.clear)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 60)
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
    OnboardingSlide2(currentPage: .constant(1))
}
