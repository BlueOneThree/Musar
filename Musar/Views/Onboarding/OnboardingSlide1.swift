//
//  OnboardingSlide1.swift
//  Musar
//
//  Created by The Blue on 26/03/2026.
//

import SwiftUI

struct OnboardingSlide1: View {
    // Background
    @State private var start: UnitPoint = .topLeading
    @State private var end: UnitPoint = .bottomTrailing
    @State private var legIndex: Int = 0
    private let path: [(UnitPoint, UnitPoint)] = [
        (.topLeading, .bottomTrailing),
        (.topTrailing, .bottomLeading),
        (.bottomTrailing, .topLeading),
        (.bottomLeading, .topTrailing)
    ]
    var mainBCK: LinearGradient {
        LinearGradient(colors: [.prim10, .prim0], startPoint: start, endPoint: end)
    }
    
    @Binding var currentPage: Int
    
    var body: some View {
        ZStack{
            mainBCK
                .ignoresSafeArea()
                .onAppear {
                    start = path[0].0
                    end = path[0].1
                    animateNextLeg()
                }
            
            VStack(spacing: 0) {
                            // Page indicator
                            HStack(spacing: 8) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(.neut0)
                                    .frame(width: 40, height: 4)
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(.neut0.opacity(0.3))
                                    .frame(width: 40, height: 4)
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(.neut0.opacity(0.3))
                                    .frame(width: 40, height: 4)
                            }
                            .padding(.top, 60)
             
                            Spacer()
             
                            // Icon
                            ZStack {
                                Image(systemName: "pencil.tip")
                                    .font(.largeTitle)
                                    .foregroundStyle(.prim0)
                                    .frame(width: 80, height: 80)
                                    .glassEffect(.clear)
                            }
             
                            Spacer()
                                .frame(height: 60)
             
                            // Text content
                            VStack(spacing: 16) {
                                Text("Blank session.\nNo idea where to start.")
                                    .font(.title.weight(.semibold))
                                    .foregroundStyle(.neut0)
                                    .multilineTextAlignment(.center)
             
                                Text("We've all been there. That feeling\nwhen the cursor just blinks at you.")
                                    .font(.title2.weight(.semibold))
                                    .foregroundStyle(.neut3)
                                    .multilineTextAlignment(.center)
                            }
             
                            Spacer()
             
                            // Next button
                            Button {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    currentPage = 1
                                }
                            } label: {
                                Text("Next")
                                    .font(.title3)
                                    .foregroundStyle(.neut0)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .glassEffect(.clear)
                            }
                            .padding(.horizontal, 40)
                            .padding(.bottom, 60)
            } // VStack
            
        } // ZStack
    }
    
    private func animateNextLeg() {
        let next = (legIndex + 1) % path.count
        withAnimation(.easeInOut(duration: 10)) {
            start = path[next].0
            end = path[next].1
        }
        legIndex = next
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            animateNextLeg()
        }
    }
}

#Preview {
    OnboardingSlide1(currentPage: .constant(0))
}
