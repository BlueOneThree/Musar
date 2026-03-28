//
//  HiphopTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct HipHopTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#141414"))

            Canvas { context, size in
                // Horizontal lines
                for i in 0..<8 {
                    let y = 25.0 + Double(i) * 16
                    var line = Path()
                    line.move(to: CGPoint(x: 20, y: y))
                    line.addLine(to: CGPoint(x: size.width - 20, y: y))
                    context.stroke(line, with: .color(.yellow.opacity(0.3)), lineWidth: 2)
                }
                
                // Vertical lines
                for i in 0..<8 {
                    let x = 25.0 + Double(i) * 16
                    var line = Path()
                    line.move(to: CGPoint(x: x, y: 20))
                    line.addLine(to: CGPoint(x: x, y: size.width - 20))
                    context.stroke(line, with: .color(.yellow.opacity(0.3)), lineWidth: 2)
                }

                // Dots
                let beats: [(CGFloat, CGFloat, CGFloat, Double)] = [
                    (30, 25, 7, 0.15), (60, 41, 5, 0.12),
                    (95, 57, 8, 0.14), (40, 73, 6, 0.1),
                    (110, 73, 5, 0.12), (70, 89, 7, 0.13),
                    (30, 105, 6, 0.1), (100, 105, 5, 0.12),
                    (55, 121, 8, 0.14), (120, 41, 4, 0.1),
                ]
                for (x, y, s, _) in beats {
                    let dot = Path(ellipseIn: CGRect(x: x, y: y - s/2, width: s, height: s))
                    context.fill(dot, with: .color(.yellow.opacity(0.5)))
                }
            }
            // Text
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Hip-Hop")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtHiphop)
                Text("raw · gritty · urban")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtHiphop.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    HipHopTile()
        .frame(width: 160, height: 190)
}
