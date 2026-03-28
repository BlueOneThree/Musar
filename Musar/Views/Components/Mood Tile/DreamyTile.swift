//
//  DreamyTile.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct DreamyTile: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#2A4A60"))

            Canvas { context, size in
                // Large soft overlapping circles
                let circle1 = Path(ellipseIn: CGRect(x: 10, y: 40, width: 100, height: 100))
                context.fill(circle1, with: .color(.txtDreamy.opacity(0.07)))

                let circle2 = Path(ellipseIn: CGRect(x: 50, y: 25, width: 90, height: 90))
                context.fill(circle2, with: .color(.txtDreamy.opacity(0.09)))

                let circle3 = Path(ellipseIn: CGRect(x: 70, y: 60, width: 70, height: 70))
                context.fill(circle3, with: .color(.txtDreamy.opacity(0.08)))

                // Tiny star-like dots
                let stars: [(CGFloat, CGFloat, CGFloat)] = [
                    (110, 20, 3),
                    (40, 30, 2),
                    (130, 55, 2.5),
                    (25, 80, 2),
                    (115, 100, 2),
                    (80, 15, 1.5),
                    (45, 120, 2),
                ]
                for (x, y, s) in stars {
                    let dot = Path(ellipseIn: CGRect(x: x, y: y, width: s, height: s))
                    context.fill(dot, with: .color(.txtDreamy.opacity(0.5)))
                }
            }

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Dreamy")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtDreamy)
                Text("ambient · soft · hazy")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtDreamy.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    DreamyTile()
        .frame(width: 160, height: 190)
}
