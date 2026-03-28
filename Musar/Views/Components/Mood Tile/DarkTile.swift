//
//  DarkTile.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct DarkTile: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#0C0C18"))

            Canvas { context, size in
                let centerX = size.width * 0.5
                let centerY = size.height * 0.4

                // Concentric rings
                for i in 1...6 {
                    let radius = Double(i) * 16.0
                    let ring = Path(ellipseIn: CGRect(
                        x: centerX - radius,
                        y: centerY - radius,
                        width: radius * 2,
                        height: radius * 2
                    ))
                    let opacity = 0.12 - Double(i) * 0.012
                    context.stroke(ring, with: .color(.txtDark.opacity(max(opacity, 0.4))), lineWidth: 0.8)
                }

                // Center filled dot
                let dot = Path(ellipseIn: CGRect(x: centerX - 4, y: centerY - 4, width: 8, height: 8))
                context.fill(dot, with: .color(.txtDark.opacity(0.6)))
            }

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Dark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtDark)
                Text("cold · cinematic · heavy")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtDark.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    DarkTile()
        .frame(width: 160, height: 190)
}
