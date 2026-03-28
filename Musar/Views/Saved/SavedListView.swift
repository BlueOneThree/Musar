//
//  SavedListView.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI
import SwiftData

struct SavedListView: View {
    @Query(sort: \SavedSession.date, order: .reverse) private var sessions: [SavedSession]
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = SavedViewModel()
    
    @State private var selectedSessionID: UUID?

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    HStack {
                        Text({
                            var s = AttributedString("Find your older magic")
                            s.font = .system(size: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
                            if let range = s.range(of: "Find your older") {
                                s[range].foregroundColor = .seco10
                            }
                            if let range = s.range(of: "magic") {
                                s[range].foregroundColor = .seco0
                            }
                            return s
                        }())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical)

                        // Filter menu
                        Menu {
                            ForEach(SavedFilter.allCases, id: \.self) { filter in
                                Button {
                                    viewModel.filter = filter
                                } label: {
                                    HStack {
                                        Text(filter.rawValue)
                                        if viewModel.filter == filter {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.system(size: 24))
                                .foregroundStyle(.seco10)
                                .padding(.horizontal)
                        }
                    }
//                    .padding(.horizontal)
//                    .padding(.top, 16)

                    // Content
                    if sessions.isEmpty {
                        // Empty state
                        VStack(spacing: 16) {
                            Spacer()
                            Image(systemName: "bookmark")
                                .font(.system(size: 40))
                                .foregroundStyle(.seco10)
                            Text("No saved sessions yet")
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(.seco10)
                            Text("Tap Save on any inspiration\nto find it here later.")
                                .font(.body)
                                .foregroundStyle(.seco10.opacity(0.4))
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        // Session list
                        List {
                            ForEach(viewModel.filtered(sessions)) { session in
                                Button {
                                    selectedSessionID = session.id
                                } label: {
                                    SavedCardView(session: session)
                                }
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            viewModel.delete(session, context: modelContext)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            // Background
            .animatedBackground()
            
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: Binding(
                get: { selectedSessionID != nil },
                set: { if !$0 { selectedSessionID = nil } }
            )) {
                if let session = sessions.first(where: { $0.id == selectedSessionID }) {
                    InspirationResultView(
                        result: session.toInspirationResult(),
                        onSave: { _ in }
                    )
                }
            }
        }
    }
}

#Preview {
    SavedListView()
        .modelContainer(for: SavedSession.self, inMemory: true)
}
