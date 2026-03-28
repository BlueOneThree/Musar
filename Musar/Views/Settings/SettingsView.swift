//
//  SettingsView.swift
//  Musar
//
//  Created by The Blue on 27/03/2026.
//

import SwiftUI
 
struct SettingsView: View {
    @AppStorage("themeMode") private var themeMode = "System"
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("username") private var username = "Guest"
    @AppStorage("email") private var email = ""
 
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    Text({
                        var s = AttributedString("Just settings")
                        s.font = .system(size: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
                        if let range = s.range(of: "Just") {
                            s[range].foregroundColor = .seco10
                        }
                        if let range = s.range(of: "settings") {
                            s[range].foregroundColor = .seco0
                        }
                        return s
                    }())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
 
                    // MARK: - Account
                    VStack(alignment: .leading, spacing: 12) {
                        Text("ACCOUNT")
                            .font(.headline)
                            .italic()
                            .foregroundStyle(.prim10)
 
                        SettingsRow(label: "Username", value: username)
                        SettingsRow(label: "E-mail", value: email.isEmpty ? "Not signed in" : email)
                    }
 
                    // MARK: - Preferences
                    VStack(alignment: .leading, spacing: 12) {
                        Text("PREFERENCES")
                            .font(.headline)
                            .italic()
                            .foregroundStyle(.prim10)
 
                        // Theme Mode
                        // Theme Mode
                        HStack {
                            Text("Theme Mode")
                                .font(.body)
                                .foregroundStyle(.seco10)
                            Spacer()
                            Menu {
                                Button {
                                    themeMode = "Light"
                                } label: {
                                    HStack {
                                        Text("Light")
                                        if themeMode == "Light" { Image(systemName: "checkmark") }
                                    }
                                }
                                Button {
                                    themeMode = "Dark"
                                } label: {
                                    HStack {
                                        Text("Dark")
                                        if themeMode == "Dark" { Image(systemName: "checkmark") }
                                    }
                                }
                                Button {
                                    themeMode = "System"
                                } label: {
                                    HStack {
                                        Text("System")
                                        if themeMode == "System" { Image(systemName: "checkmark") }
                                    }
                                }
                            } label: {
                                Text(themeMode)
                                    .font(.body)
                                    .foregroundStyle(.prim0)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.prim10, lineWidth: 1)
                        )
 
                        // Notification Toggle
                        HStack {
                            Text("Notification")
                                .font(.body)
                                .foregroundStyle(.seco10)
                            Spacer()
                            Toggle("", isOn: $notificationsEnabled)
                                .tint(.prim0)
                                .labelsHidden()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.prim10, lineWidth: 1)
                        )
                    }
 
                    // MARK: - About
                    VStack(alignment: .leading, spacing: 12) {
                        Text("ABOUT")
                            .font(.headline)
                            .italic()
                            .foregroundStyle(.prim10)
 
                        SettingsRow(label: "Version", value: "v1.0")
                    }
                }
                .padding(.horizontal)
            }
        }
        // Background
        .animatedBackground()
    }
}

#Preview {
    SettingsView()
}
