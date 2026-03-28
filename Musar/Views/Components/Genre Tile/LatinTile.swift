//
//  LatinTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct LatinTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#5C2E1E"))

            Canvas { context, size in
                // Curved arcs
                for i in 0..<4 {
                    let centerX = 40.0 + Double(i) * 30
                    var arc = Path()
                    arc.addArc(
                        center: CGPoint(x: centerX, y: 70),
                        radius: 25 + Double(i) * 8,
                        startAngle: .degrees(-180),
                        endAngle: .degrees(180),
                        clockwise: false
                    )
                    context.stroke(arc, with: .color(.txtLatin.opacity(0.4)), lineWidth: 0.8)
                }

                // Dots
                let clusters: [(CGFloat, CGFloat)] = [
                    (35, 40), (75, 35), (110, 50),
                    (50, 80), (90, 75), (30, 105),
                    (70, 100), (115, 90),
                ]
                for (cx, cy) in clusters {
                    let d = Path(ellipseIn: CGRect(x: cx, y: cy, width: 6, height: 6))
                    context.fill(d, with: .color(.txtLatin.opacity(0.2)))
                }

                // Tiny Dots
                let accents: [(CGFloat, CGFloat)] = [
                    (55, 55), (95, 60), (45, 90), (100, 100),
                ]
                for (x, y) in accents {
                    let d = Path(ellipseIn: CGRect(x: x, y: y, width: 3, height: 3))
                    context.fill(d, with: .color(.txtLatin.opacity(0.2)))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Latin")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtLatin)
                Text("beat · rhythmic · passionate")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtLatin.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    LatinTile()
        .frame(width: 160, height: 190)
}
