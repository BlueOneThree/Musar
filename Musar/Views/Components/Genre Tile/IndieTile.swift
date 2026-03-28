//
//  IndieTile.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct IndieTile: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#3A4438"))

            Canvas { context, size in
                // Organic wavy lines (lo-fi, raw, heartfelt)
                for i in 0..<5 {
                    let baseY = 30.0 + Double(i) * 22
                    var wave = Path()
                    wave.move(to: CGPoint(x: 15, y: baseY))
                    for x in stride(from: 15.0, to: Double(size.width) - 15, by: 3) {
                        let amplitude = 5.0 + Double(i) * 2
                        let frequency = 0.06 + Double(i) * 0.01
                        let y = baseY + sin(x * frequency + Double(i) * 1.5) * amplitude
                        wave.addLine(to: CGPoint(x: x, y: y))
                    }
                    context.stroke(wave, with: .color(.txtIndie.opacity(0.08)), lineWidth: 1)
                }

                // Small star-like dots
                let stars: [(CGFloat, CGFloat, CGFloat)] = [
                    (45, 25, 8.5), (110, 45, 4.5), (20, 64, 15),
                    (95, 90, 4.5), (70, 110, 6.5), (135, 75,9.5),
                ]
                for (x, y, s) in stars {
                    let dot = Path(ellipseIn: CGRect(x: x, y: y, width: s, height: s))
                    context.fill(dot, with: .color(.txtIndie.opacity(0.3)))
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Indie")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtIndie)
                Text("raw · lo-fi · heartfelt")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtIndie.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    IndieTile()
        .frame(width: 160, height: 190)
}
