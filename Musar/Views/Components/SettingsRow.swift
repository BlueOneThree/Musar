//
//  SettingsRow.swift
//  Musar
//
//  Created by The Blue on 27/03/2026.
//

import SwiftUI

// MARK: - Reusable Row Component
 
struct SettingsRow: View {
    let label: String
    let value: String
 
    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundStyle(.seco10)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundStyle(.prim0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.prim10, lineWidth: 1)
        )
    }
}
