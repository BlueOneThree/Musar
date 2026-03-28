//
//  AngryTile.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct AngryTile: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#7A1A1A"))

            Canvas { context, size in
                // Diagonal lines going top-left to bottom-right
                for i in 0..<8 {
                    let offset = Double(i) * 22.0
                    var line = Path()
                    line.move(to: CGPoint(x: offset - 20, y: 0))
                    line.addLine(to: CGPoint(x: offset + size.height * 0.4, y: size.height * 0.7))
                    context.stroke(line, with: .color(.txtAngry.opacity(0.4)), lineWidth: 2)
                }

                // A few stronger accent lines
                var accent1 = Path()
                accent1.move(to: CGPoint(x: 30, y: 20))
                accent1.addLine(to: CGPoint(x: size.width - 10, y: 50))
                context.stroke(accent1, with: .color(.txtAngry.opacity(0.3)), lineWidth: 1)

                var accent2 = Path()
                accent2.move(to: CGPoint(x: 20, y: 55))
                accent2.addLine(to: CGPoint(x: size.width - 10, y: 85))
                context.stroke(accent2, with: .color(.txtAngry.opacity(0.3)), lineWidth: 1)

                var accent3 = Path()
                accent3.move(to: CGPoint(x: 25, y: 90))
                accent3.addLine(to: CGPoint(x: size.width - 25, y: 120))
                context.stroke(accent3, with: .color(.txtAngry.opacity(0.3)), lineWidth: 1)
            }

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Angry")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtAngry)
                Text("hard · loud · distorted")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtAngry.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    AngryTile()
        .frame(width: 160, height: 190)
}
