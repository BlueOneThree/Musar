//
//  AfrobeatsTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct AfrobeatsTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#94380D"))

            Canvas { context, size in
                // Wavy horizontal lines
                for i in 0..<6 {
                    let baseY = 30.0 + Double(i) * 20
                    var wave = Path()
                    wave.move(to: CGPoint(x: 15, y: baseY))
                    for x in stride(from: 15.0, to: Double(size.width) - 15, by: 4) {
                        let y = baseY + sin((x + Double(i) * 20) * 0.08) * 8
                        wave.addLine(to: CGPoint(x: x, y: y))
                    }
                    context.stroke(wave, with: .color(.yellow.opacity(0.2)), lineWidth: 1)
                }

                // Dots
                let dots: [(CGFloat, CGFloat, CGFloat)] = [
                    (40, 35, 6), (90, 50, 8), (60, 70, 5),
                    (110, 85, 7), (35, 100, 5), (80, 110, 6),
                ]
                for (x, y, s) in dots {
                    let dot = Path(ellipseIn: CGRect(x: x, y: y, width: s, height: s))
                    context.fill(dot, with: .color(.yellow.opacity(0.4)))
                }
            }

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Afrobeats")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtAfro)
                Text("rhythmic · percussive · joyful")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtAfro.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    AfrobeatsTile()
        .frame(width: 160, height: 190)
}
