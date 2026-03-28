//
//  RomanticTile.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct RomanticTile: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#7A2040"))

            Canvas { context, size in
                // Overlapping soft circles (petal / bloom feel)
                let circles: [(CGFloat, CGFloat, CGFloat, Double)] = [
                    (35, 30, 80, 0.07),
                    (70, 20, 70, 0.06),
                    (50, 60, 75, 0.06),
                    (85, 50, 60, 0.05),
                    (30, 70, 50, 0.05),
                ]
                for (x, y, d, _) in circles {
                    let circle = Path(ellipseIn: CGRect(x: x, y: y, width: d, height: d))
                    context.fill(circle, with: .color(.txtRomantic.opacity(0.2)))
                }

                // Subtle ring outlines
                let ring1 = Path(ellipseIn: CGRect(x: 55, y: 35, width: 65, height: 65))
                context.stroke(ring1, with: .color(.txtRomantic.opacity(0.3)), lineWidth: 0.8)

                let ring2 = Path(ellipseIn: CGRect(x: 25, y: 45, width: 55, height: 55))
                context.stroke(ring2, with: .color(.txtRomantic.opacity(0.6)), lineWidth: 0.8)
            }

            // Text overlay
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Romantic")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtRomantic)
                Text("lush · tender · swelling")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtRomantic.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    RomanticTile()
        .frame(width: 160, height: 190)
}
