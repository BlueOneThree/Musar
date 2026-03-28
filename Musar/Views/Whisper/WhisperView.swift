//
//  WhisperView.swift
//  Musar
//
//  Created by The Blue on 28/03/2026.
//

import SwiftUI
import SwiftData

struct WhisperView: View {
    @StateObject private var viewModel = WhisperViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var userInput = ""
    @State private var showResult = false
    @State private var savedViewModel = SavedViewModel()

    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            Color.clear
                .animatedBackground()

            VStack(alignment: .leading, spacing: 0) {
                // Header
                Text({
                    var s = AttributedString("Whisper your vibe")
                    s.font = .system(size: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
                    if let range = s.range(of: "Whisper") {
                        s[range].foregroundColor = .seco10
                    }
                    if let range = s.range(of: "your vibe") {
                        s[range].foregroundColor = .seco0
                    }
                    return s
                }())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 16)

                // Subtitle
                Text("Describe what you're feeling. Musar will turn it into music direction.")
                    .font(.body)
                    .italic()
                    .foregroundStyle(.prim8)
                    .padding(.horizontal)
                    .padding(.top, 8)

                // Text input
                TextEditor(text: $userInput)
                    .font(.body)
                    .foregroundStyle(.seco10)
                    .scrollContentBackground(.hidden)
                    .padding(16)
                    .frame(height: 160)
                    .glassEffect(in: .rect(cornerRadius: 32.0))
                    .overlay(alignment: .topLeading) {
                        if userInput.isEmpty {
                            Text("3am, can't sleep, thinking about her, something slow and dark...")
                                .font(.body)
                                .foregroundStyle(.seco10.opacity(0.3))
                                .padding(24)
                                .allowsHitTesting(false)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 24)
                    .focused($isFocused)

                // Error message
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.prim0)
                        .padding(.horizontal)
                        .padding(.top, 8)
                }

                Spacer()

                // Generate button
                Button {
                    isFocused = false
                    viewModel.generate(from: userInput)
                } label: {
                    HStack(spacing: 12) {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.seco0)
                        } else {
                            Image(systemName: "sparkles")
                                .font(.body)
                        }
                        Text(viewModel.isLoading ? "Thinking..." : "Generate")
                            .font(.body.weight(.semibold))
                    }
                    .foregroundStyle(.seco0)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.seco0.opacity(0.1))
                    )
                }
                .disabled(viewModel.isLoading)
                .padding(.horizontal)
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
        .onChange(of: viewModel.result?.id) { _, newID in
            if newID != nil {
                showResult = true
            }
        }
        .navigationDestination(isPresented: $showResult) {
            if let result = viewModel.result {
                InspirationResultView(
                    result: result,
                    onSave: { label in
                        savedViewModel.save(result, label: label, context: modelContext)
                        showResult = false
                    }
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        WhisperView()
    }
}
