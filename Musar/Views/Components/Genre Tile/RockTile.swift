//
//  RockTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct RockTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#8B2020"))

            Canvas { context, size in
                // Equalizer bars
                let barHeights: [CGFloat] = [35, 55, 70, 45, 80, 60, 40, 65, 50, 30, 55, 75, 45]
                let barWidth: CGFloat = 5
                let spacing: CGFloat = 7
                let startX: CGFloat = 18

                for (i, height) in barHeights.enumerated() {
                    let x = startX + CGFloat(i) * (barWidth + spacing)
                    let y = 110 - height
                    var bar = Path()
                    bar.addRoundedRect(
                        in: CGRect(x: x, y: y, width: barWidth, height: height),
                        cornerSize: CGSize(width: 2, height: 2)
                    )
                    context.fill(bar, with: .color(.txtRock.opacity(0.2)))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Rock")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtRock)
                Text("loud · raw · unfiltered")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtRock.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    RockTile()
        .frame(width: 160, height: 190)
}
