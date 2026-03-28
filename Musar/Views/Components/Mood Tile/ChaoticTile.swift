//
//  ChaoticTile.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct ChaoticTile: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#1A0A2E"))

            Canvas { context, size in
                // Zigzag lines
                var zig1 = Path()
                zig1.move(to: CGPoint(x: 15, y: 50))
                let zig1Points: [(CGFloat, CGFloat)] = [
                    (30, 35), (45, 55), (60, 30), (75, 60),
                    (90, 25), (105, 55), (120, 35), (140, 50)
                ]
                for p in zig1Points { zig1.addLine(to: CGPoint(x: p.0, y: p.1)) }
                context.stroke(zig1, with: .color(.txtChaotic.opacity(0.5)), lineWidth: 1)

                var zig2 = Path()
                zig2.move(to: CGPoint(x: 10, y: 85))
                let zig2Points: [(CGFloat, CGFloat)] = [
                    (28, 70), (46, 95), (64, 68), (82, 92),
                    (100, 72), (118, 90), (136, 75), (145, 85)
                ]
                for p in zig2Points { zig2.addLine(to: CGPoint(x: p.0, y: p.1)) }
                context.stroke(zig2, with: .color(.txtChaotic.opacity(0.5)), lineWidth: 0.8)

                // X marks scattered
                let xMarks: [(CGFloat, CGFloat, CGFloat)] = [
                    (40, 110, 6), (100, 30, 5), (120, 100, 7),
                    (25, 40, 4), (85, 115, 5),
                ]
                for (x, y, s) in xMarks {
                    var xPath = Path()
                    xPath.move(to: CGPoint(x: x - s, y: y - s))
                    xPath.addLine(to: CGPoint(x: x + s, y: y + s))
                    xPath.move(to: CGPoint(x: x + s, y: y - s))
                    xPath.addLine(to: CGPoint(x: x - s, y: y + s))
                    context.stroke(xPath, with: .color(.txtChaotic.opacity(0.2)), lineWidth: 0.8)
                }

                // Scattered dots
                let dots: [(CGFloat, CGFloat)] = [(60, 105), (130, 60), (30, 75)]
                for (x, y) in dots {
                    let dot = Path(ellipseIn: CGRect(x: x, y: y, width: 3, height: 3))
                    context.fill(dot, with: .color(.txtChaotic.opacity(0.5)))
                }
            }

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Chaotic")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtChaotic)
                Text("glitchy · unpredictable · wild")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtChaotic.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    ChaoticTile()
        .frame(width: 160, height: 190)
}
