//
// MainViewView.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct MainViewView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @AppStorage("themeMode") private var themeMode = "System"

    var colorScheme: ColorScheme? {
        switch themeMode {
        case "Light": return .light
        case "Dark": return .dark
        default: return nil  // nil = follow device
        }
    }

    var body: some View {
        Group {
            if hasSeenOnboarding {
                TabView {
                    Tab("Magic", systemImage: "sparkle") {
                        MusarView()
                    }
                    Tab("Saved", systemImage: "bookmark") {
                        SavedListView()
                    }
                    Tab("Settings", systemImage: "gearshape") {
                        SettingsView()
                    }
                }
            } else {
                OnboardingView()
            }
        }
        .preferredColorScheme(colorScheme)
    }
}

#Preview {
    MainViewView()
}
