//
//  AnimatedBackground.swift
//  Musar
//
//  Created by The Blue on 27/03/2026.
//

import SwiftUI

struct AnimatedBackground: ViewModifier {
    @State private var startAnimation = false

    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [.neut0, .seco2],
                    startPoint: startAnimation ? .topLeading : .bottomLeading,
                    endPoint: startAnimation ? .bottomTrailing : .topTrailing
                )
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 5.0).repeatForever()) {
                        startAnimation.toggle()
                    }
                }
            )
    }
}

extension View {
    func animatedBackground() -> some View {
        modifier(AnimatedBackground())
    }
}
