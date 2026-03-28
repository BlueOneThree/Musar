//
//  PopTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct PopTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#D44B8A"))

            Canvas { context, size in
                // Scattered bubbles (bright, catchy, fun)
                let bubbles: [(CGFloat, CGFloat, CGFloat, Double)] = [
                    (25, 20, 40, 0.08),
                    (80, 35, 55, 0.06),
                    (50, 70, 35, 0.07),
                    (110, 15, 30, 0.06),
                    (95, 80, 45, 0.05),
                    (30, 55, 25, 0.07),
                ]
                for (x, y, d, _) in bubbles {
                    let bubble = Path(ellipseIn: CGRect(x: x, y: y, width: d, height: d))
                    context.fill(bubble, with: .color(.txtPop.opacity(0.3)))
                }

                // Small sparkle dots
                let dots: [(CGFloat, CGFloat, CGFloat)] = [
                    (45, 30, 4), (100, 55, 3), (70, 95, 3.5),
                    (120, 40, 2.5), (35, 85, 3), (90, 15, 2),
                ]
                for (x, y, s) in dots {
                    let dot = Path(ellipseIn: CGRect(x: x, y: y, width: s, height: s))
                    context.fill(dot, with: .color(.txtPop.opacity(0.3)))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Pop")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtPop)
                Text("bright · catchy · polished")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtPop.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    PopTile()
        .frame(width: 160, height: 190)
}
