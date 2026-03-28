//
//  SaveButton.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct SaveButton: View {
    var isSaved: Bool = false

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                .font(.body)
            Text(isSaved ? "Unsave" : "Save")
                .font(.body)
        }
        .foregroundStyle(isSaved ? .prim0 : .seco0)
        .frame(width: 170, height: 56)
        .background(.clear)
        .glassEffect(.clear)
    }
}

#Preview {
    VStack(spacing: 20) {
        SaveButton(isSaved: false)
        SaveButton(isSaved: true)
    }
}
