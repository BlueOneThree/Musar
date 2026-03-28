//
//  SignUpView.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI
 
struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    var onComplete: () -> Void
 
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Spacer()
 
                // Welcome header
                VStack(spacing: 8) {
                    Text("Welcome to")
                        .font(.title2.weight(.medium))
                        .foregroundStyle(.seco10)
                    Text("Musar")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundStyle(.seco8)
                }
 
                Spacer()
                    .frame(height: 20)
 
                // Sign-in buttons
                VStack(spacing: 12) {
                    SignInButton(
                        icon: "envelope.fill",
                        text: "Sign in with Mail",
                        action: {
                            // TODO: Email auth
                        }
                    )
 
                    SignInButton(
                        icon: "g.circle.fill",
                        text: "Sign in with Google",
                        isSystemIcon: false,
                        action: {
                            // TODO: Google OAuth
                        }
                    )
 
                    SignInButton(
                        icon: "apple.logo",
                        text: "Sign in with Apple",
                        action: {
                            // TODO: Apple Sign In
                        }
                    )
                }
                .padding(.horizontal, 40)
 
                Spacer()
 
                // Get Started (skip sign-in, guest mode)
                Button {
                    onComplete()
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
                .padding(.bottom, 60)
            }
        }
        // Background
        .animatedBackground()
    }
}
 
// MARK: - Sign-In Button Component
 
struct SignInButton: View {
    let icon: String
    let text: String
    var isSystemIcon: Bool = true
    let action: () -> Void
 
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if isSystemIcon {
                    Image(systemName: icon)
                        .font(.system(size: 25))
                        .frame(width: 25, height: 25, alignment: .center)
                } else {
                    Image("google")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                }
                Spacer()
                Text(text)
                    .font(.system(size: 15, weight: .medium))
                    .frame(width: 220, alignment: .leading)
            }
            .foregroundStyle(.seco10)
            .frame(width: 200, alignment: .leading)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.seco10.opacity(0.2), lineWidth: 1)
            )
        }
    }
}
 
#Preview {
    SignUpView { }
}
