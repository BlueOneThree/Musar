//
//  OnboardingSlide3.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct OnboardingSlide3: View {
    
    @State private var showSignUp = false
    var onGetStarted: () -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()

                // Icon
                ZStack {
                    Image(systemName: "wand.and.sparkles.inverse")
                        .font(.largeTitle)
                        .foregroundStyle(.seco0)
                        .frame(width: 80, height: 80)
                        .glassEffect(.clear)
                }

                Spacer()
                    .frame(height: 60)

                // Text content
                VStack(spacing: 16) {
                    Text("Ready to create?")
                        .font(.title.weight(.semibold))
                        .foregroundStyle(.seco10)

                    Text("Under 30 seconds to your next\nidea. No account needed to start.")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.terti7)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                // Get Started button (guest mode)
                Button {
                    onGetStarted()
                } label: {
                    Text("Get Started")
                        .font(.title3)
                        .foregroundStyle(.neut0)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.seco0)
                        )
                }
                .padding(.horizontal, 40)

                // Create account link
                Button {
                    showSignUp = true
                } label: {
                    HStack(spacing: 4) {
                        Text("or you can")
                            .foregroundStyle(.seco10.opacity(0.6))
                        Text("create an account")
                            .foregroundStyle(.seco0)
                            .underline()
                    }
                    .font(.system(size: 13))
                }
                .padding(.top, 16)
                .padding(.bottom, 60)
            }
        }
        // Background
        .animatedBackground()
        
        .sheet(isPresented: $showSignUp) {
            SignUpView {
                showSignUp = false
                onGetStarted()
            }
        }
    }
}

#Preview {
    OnboardingSlide3 { }
}
