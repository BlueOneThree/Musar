//
//  AgainButton.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct AgainButton: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "wand.and.sparkles.inverse")
                .font(.body)
            Text("Again")
                .font(.body)
        }
        .foregroundStyle(.prim0)
        .frame(width: 170, height: 56)
        .background(.clear)
        .glassEffect(.clear)
    }
}

#Preview {
    AgainButton()
}
