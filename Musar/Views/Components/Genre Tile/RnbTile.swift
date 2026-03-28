//
//  RnbTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct RnBTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#4A2D6E"))

            Canvas { context, size in
                // Overlapping  circles
                let circles: [(CGFloat, CGFloat, CGFloat, Double)] = [
                    (30, 25, 90, 0.06),
                    (65, 40, 80, 0.05),
                    (45, 65, 70, 0.06),
                    (80, 55, 60, 0.05),
                ]
                for (x, y, d, _) in circles {
                    let circle = Path(ellipseIn: CGRect(x: x, y: y, width: d, height: d))
                    context.fill(circle, with: .color(.txtRnb.opacity(0.2)))
                }

                // Subtle ring
                let ring = Path(ellipseIn: CGRect(x: 45, y: 45, width: 75, height: 75))
                context.stroke(ring, with: .color(.txtRnb.opacity(0.4)), lineWidth: 2)

                // Accent dots
                let dots: [(CGFloat, CGFloat)] = [(110, 25), (30, 95), (120, 85)]
                for (x, y) in dots {
                    let d = Path(ellipseIn: CGRect(x: x, y: y, width: 3, height: 3))
                    context.fill(d, with: .color(.txtRnb.opacity(0.5)))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("R&B")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtRnb)
                Text("smooth · sensual · polished")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtRnb.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    RnBTile()
        .frame(width: 160, height: 190)
}
