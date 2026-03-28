//
//  MelancholicTile.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct MelancholicTile: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#1E2E4A"))

            Canvas { context, size in
                // Horizontal lines (like sheet music / piano roll)
                for i in 0..<6 {
                    let y = 30.0 + Double(i) * 18
                    var line = Path()
                    line.move(to: CGPoint(x: 25, y: y))
                    line.addLine(to: CGPoint(x: size.width - 25, y: y))
                    context.stroke(line, with: .color(.txtMelancholic.opacity(0.2)), lineWidth: 3)
                }

                // Scattered dots on the lines (like notes)
                let dots: [(CGFloat, CGFloat, CGFloat)] = [
                    (100, 30, 10),
                    (55, 48, 7),
                    (120, 66, 12),
                    (40, 84, 6),
                    (90, 102, 9),
                    (130, 66, 5),
                    (70, 120, 8),
                ]
                for (x, y, size) in dots {
                    let dot = Path(ellipseIn: CGRect(x: x, y: y - size/2, width: size, height: size))
                    context.fill(dot, with: .color(.txtMelancholic.opacity(0.5)))
                }
            }

            // Text overlay
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Melancholic")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtMelancholic)
                Text("slow · minor · raw")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtMelancholic.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    MelancholicTile()
        .frame(width: 160, height: 190)
}
