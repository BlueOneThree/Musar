//
//  GenreRandomTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct GenreRandomTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#1F1F1F"))

            Canvas { context, size in
                let w = size.width
                let h = size.height

                // Horizontal lines
                let lines: [(CGFloat, CGFloat)] = [
                    (15, 61), (32, 68), (48, 76), (65, 83), (82, 91)
                ]
                for (y, lineWidth) in lines {
                    let scaledY = y * h / 167
                    let scaledW = lineWidth * w / 136
                    var line = Path()
                    line.addRect(CGRect(x: 0, y: scaledY, width: scaledW, height: 1))
                    context.fill(line, with: .color(.txtGenreRandom.opacity(0.4)))
                }

                // Large X diagonals crossing the tile
                var xPath = Path()
                xPath.move(to: CGPoint(x: 0, y: 0))
                xPath.addLine(to: CGPoint(x: w, y: h * 0.63))
                xPath.move(to: CGPoint(x: w, y: 0))
                xPath.addLine(to: CGPoint(x: 0, y: h * 0.63))
                context.stroke(xPath, with: .color(.txtGenreRandom.opacity(0.05)), lineWidth: 1)

                // Circles
                let circle1 = Path(ellipseIn: CGRect(
                    x: w * 0.56, y: h * 0.024, width: w * 0.33, height: w * 0.33
                ))
                context.fill(circle1, with: .color(.txtGenreRandom.opacity(0.4)))

                let circle2 = Path(ellipseIn: CGRect(
                    x: w * 0.11, y: h * 0.27, width: w * 0.22, height: w * 0.23
                ))
                context.fill(circle2, with: .color(.txtGenreRandom.opacity(0.2)))

                let circle3 = Path(ellipseIn: CGRect(
                    x: w * 0.72, y: h * 0.32, width: w * 0.28, height: w * 0.28
                ))
                context.fill(circle3, with: .color(.txtGenreRandom.opacity(0.3)))

                // Diamond shape (center area)
                let dCenterX = w * 0.50
                let dCenterY = h * 0.29
                let dSize: CGFloat = w * 0.08
                var diamond = Path()
                diamond.move(to: CGPoint(x: dCenterX, y: dCenterY - dSize))
                diamond.addLine(to: CGPoint(x: dCenterX + dSize, y: dCenterY))
                diamond.addLine(to: CGPoint(x: dCenterX, y: dCenterY + dSize))
                diamond.addLine(to: CGPoint(x: dCenterX - dSize, y: dCenterY))
                diamond.closeSubpath()
                context.fill(diamond, with: .color(.txtGenreRandom.opacity(0.8)))
                context.stroke(diamond, with: .color(.txtGenreRandom.opacity(0.2)), lineWidth: 1)

                // Scattered small dots
                let dots: [(CGFloat, CGFloat)] = [
                    (0.18, 0.10), (0.40, 0.24), (0.79, 0.15),
                    (0.32, 0.42), (0.90, 0.46), (0.07, 0.51),
                ]
                for (px, py) in dots {
                    let dot = Path(ellipseIn: CGRect(
                        x: w * px - 1.5, y: h * py - 1.5, width: 3, height: 3
                    ))
                    context.fill(dot, with: .color(.txtGenreRandom.opacity(0.5)))
                }
            }

            // Text overlay
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Random")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtGenreRandom)
                Text("surprise")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtGenreRandom.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    GenreRandomTile()
        .frame(width: 160, height: 190)
}
