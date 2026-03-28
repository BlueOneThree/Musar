//
//  OnboardingView.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI
 
struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentPage = 0
 
    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingSlide1(currentPage: $currentPage)
                .tag(0)
            OnboardingSlide2(currentPage: $currentPage)
                .tag(1)
            OnboardingSlide3 {
                hasSeenOnboarding = true
            }
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
    }
}
 
#Preview {
    OnboardingView()
}
