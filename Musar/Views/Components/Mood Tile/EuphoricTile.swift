//
//  EuphoricTile.swift
//  Musar
//
//  Created by The Blue on 25/03/2026.
//

import SwiftUI

struct EuphoricTile: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#C4581A"))

            Canvas { context, size in
                // Large circle outline (left area)
                let bigCircle = Path(ellipseIn: CGRect(x: 15, y: 20, width: 110, height: 110))
                context.stroke(bigCircle, with: .color(.txtEuphoric.opacity(0.3)), lineWidth: 1.5)

                // Medium circle outline
                let medCircle = Path(ellipseIn: CGRect(x: 55, y: 55, width: 50, height: 50))
                context.stroke(medCircle, with: .color(.txtEuphoric.opacity(0.3)), lineWidth: 1)

                // Filled bubbles
                let bubble1 = Path(ellipseIn: CGRect(x: 95, y: 25, width: 38, height: 38))
                context.fill(bubble1, with: .color(.txtEuphoric.opacity(0.3)))

                let bubble2 = Path(ellipseIn: CGRect(x: 120, y: 10, width: 18, height: 18))
                context.fill(bubble2, with: .color(.txtEuphoric.opacity(0.1)))

                let bubble3 = Path(ellipseIn: CGRect(x: 60, y: 8, width: 12, height: 12))
                context.fill(bubble3, with: .color(.txtEuphoric.opacity(0.4)))

                let bubble4 = Path(ellipseIn: CGRect(x: 30, y: 50, width: 8, height: 8))
                context.fill(bubble4, with: .color(.txtEuphoric.opacity(0.3)))

                // Small triangle accent
                var triangle = Path()
                triangle.move(to: CGPoint(x: 42, y: 15))
                triangle.addLine(to: CGPoint(x: 50, y: 30))
                triangle.addLine(to: CGPoint(x: 34, y: 30))
                triangle.closeSubpath()
                context.stroke(triangle, with: .color(.txtEuphoric.opacity(0.2)), lineWidth: 1)
            }

            // Text overlay
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text("Euphoric")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.txtEuphoric)
                Text("fast · major · bright")
                    .font(.system(size: 9))
                    .foregroundStyle(.txtEuphoric.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
    }
}

#Preview {
    EuphoricTile()
        .frame(width: 160, height: 190)
}
