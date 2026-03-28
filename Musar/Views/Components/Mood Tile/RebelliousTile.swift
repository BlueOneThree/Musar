//
//  RebelliousTile.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct RebelliousTile: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#1A1A1A"))

            Canvas { context, size in
                // Horizontal lines (subtle, like interference)
                for i in 0..<6 {
                    let y = 20.0 + Double(i) * 20
                    var line = Path()
                    line.move(to: CGPoint(x: 20, y: y))
                    line.addLine(to: CGPoint(x: size.width - 20, y: y))
                    context.stroke(line, with: .color(.txtRebellious.opacity(0.2)), lineWidth: 2)
                }

                // Lightning bolt (center)
                var bolt = Path()
                bolt.move(to: CGPoint(x: 85, y: 20))
                bolt.addLine(to: CGPoint(x: 65, y: 70))
                bolt.addLine(to: CGPoint(x: 90, y: 65))
                bolt.addLine(to: CGPoint(x: 70, y: 120))
                bolt.addLine(to: CGPoint(x: 100, y: 60))
                bolt.addLine(to: CGPoint(x: 75, y: 65))
                bolt.closeSubpath()

                context.stroke(bolt, with: .color(.txtRebellious.opacity(0.5)), lineWidth: 1)
            }

            // Text overlay
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Rebellious")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtRebellious)
                Text("raw · electric · defiant")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtRebellious.opacity(0.6))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    RebelliousTile()
        .frame(width: 160, height: 190)
}
