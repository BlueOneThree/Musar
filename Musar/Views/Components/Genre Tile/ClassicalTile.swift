//
//  ClassicalTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct ClassicalTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#1A1A29"))

            Canvas { context, size in
                let centerX = size.width * 0.5
                let centerY = size.height * 0.4

                // Geometric diamond shapes
                for i in 1...4 {
                    let s = Double(i) * 20.0
                    var diamond = Path()
                    diamond.move(to: CGPoint(x: centerX, y: centerY - s))
                    diamond.addLine(to: CGPoint(x: centerX + s, y: centerY))
                    diamond.addLine(to: CGPoint(x: centerX, y: centerY + s))
                    diamond.addLine(to: CGPoint(x: centerX - s, y: centerY))
                    diamond.closeSubpath()
                    let opacity = 0.1 - Double(i) * 0.015
                    context.stroke(diamond, with: .color(.txtClassical.opacity(max(opacity, 0.4))), lineWidth: 0.6)
                }

                // Small dot at center
                let dot = Path(ellipseIn: CGRect(x: centerX - 3, y: centerY - 3, width: 6, height: 6))
                context.fill(dot, with: .color(.txtClassical.opacity(0.25)))

                // Corner accent dots
                let accents: [(CGFloat, CGFloat)] = [
                    (30, 25), (125, 30), (25, 110), (130, 105),
                ]
                for (x, y) in accents {
                    let d = Path(ellipseIn: CGRect(x: x, y: y, width: 3, height: 3))
                    context.fill(d, with: .color(.txtClassical.opacity(0.25)))
                }
            }

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Classical")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtClassical)
                Text("elegant · structured · timeless")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtClassical.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    ClassicalTile()
        .frame(width: 160, height: 190)
}
