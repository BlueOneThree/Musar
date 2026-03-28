//
//  NostalgicTile.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct NostalgicTile: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#7A5530"))

            Canvas { context, size in
                let centerX = size.width * 0.55
                let centerY = size.height * 0.45

                // Concentric rings expanding outward
                for i in 1...5 {
                    let radius = Double(i) * 22.0
                    let ring = Path(ellipseIn: CGRect(
                        x: centerX - radius,
                        y: centerY - radius,
                        width: radius * 2,
                        height: radius * 2
                    ))
                    context.stroke(ring, with: .color(.txtNostalgic.opacity(0.2)), lineWidth: 0.8)
                }

                // Small dot at center
                let dot = Path(ellipseIn: CGRect(x: centerX - 3, y: centerY - 3, width: 6, height: 6))
                context.fill(dot, with: .color(.txtNostalgic.opacity(0.5)))

                // Tiny accent dot offset
                let accent = Path(ellipseIn: CGRect(x: centerX + 30, y: centerY - 40, width: 4, height: 4))
                context.fill(accent, with: .color(.txtNostalgic.opacity(0.8)))
            }

            // Text overlay
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Nostalgic")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtNostalgic)
                Text("warm · hazy · aching")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtNostalgic.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    NostalgicTile()
        .frame(width: 160, height: 190)
}
