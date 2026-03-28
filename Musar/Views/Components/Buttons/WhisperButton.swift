//
//  WhisperButton.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct WhisperButton: View {
    var body: some View {
        HStack(spacing : 16) {
            Image(systemName: "sparkles")
                .font(.body)
            Text("Whisper")
                .font(.body)
        }
        .foregroundStyle(.seco0)
        .frame(width: 170, height: 56)
        .background(.clear)
        .glassEffect(.clear)
    }
}

#Preview {
    WhisperButton()
}
