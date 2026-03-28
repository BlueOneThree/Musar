//
//  SoulTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct SoulTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#7A5C3A"))

            Canvas { context, size in
                let centerX = size.width * 0.5
                let centerY = size.height * 0.4

                // Concentric arcs
                for i in 1...4 {
                    let radius = Double(i) * 24.0
                    var arc = Path()
                    arc.addArc(
                        center: CGPoint(x: centerX, y: centerY),
                        radius: radius,
                        startAngle: .degrees(-140),
                        endAngle: .degrees(-40),
                        clockwise: false
                    )
                    context.stroke(arc, with: .color(.txtSoul.opacity(0.5)), lineWidth: 1)
                }

                // Warm inner glow circle
                let glow = Path(ellipseIn: CGRect(x: centerX - 15, y: centerY - 15, width: 30, height: 30))
                context.fill(glow, with: .color(.txtSoul.opacity(0.2)))

                // Center dot
                let dot = Path(ellipseIn: CGRect(x: centerX - 4, y: centerY - 4, width: 8, height: 8))
                context.fill(dot, with: .color(.neut0.opacity(0.5)))

                // Small accent dots
                let accents: [(CGFloat, CGFloat)] = [(35, 30), (120, 50), (100, 100)]
                for (x, y) in accents {
                    let d = Path(ellipseIn: CGRect(x: x, y: y, width: 3, height: 3))
                    context.fill(d, with: .color(.neut0.opacity(0.15)))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Soul")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtSoul)
                Text("warm · rich · deeply felt")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtSoul.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    SoulTile()
        .frame(width: 160, height: 190)
}
