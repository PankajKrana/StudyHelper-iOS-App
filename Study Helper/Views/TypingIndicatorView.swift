//
//  TypingIndicatorView.swift
//  Study Helper
//
//  Created by Pankaj Kumar Rana on 12/12/25.
//

import SwiftUI

struct TypingIndicatorView: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        HStack(spacing: 10) {
            Avatar(isUser: false)

            Capsule()
                .fill(Color(.systemGray5))
                .frame(width: 50, height: 28)
                .overlay(
                    HStack(spacing: 6) {
                        Dot(phase: phase, index: 0)
                        Dot(phase: phase, index: 1)
                        Dot(phase: phase, index: 2)
                    }
                )
            Spacer()
        }
        .onAppear {
            withAnimation(.linear.repeatForever(autoreverses: false)) {
                phase = 1
            }
        }
    }
}

struct Dot: View {
    var phase: CGFloat
    var index: Int

    var body: some View {
        Circle()
            .frame(width: 6, height: 6)
            .opacity(opacity)
            .offset(y: offset)
    }

    private var offset: CGFloat {
        let t = (phase + CGFloat(index) * 0.2).truncatingRemainder(dividingBy: 1)
        return -6 * sin(t * .pi * 2)
    }

    private var opacity: Double {
        let t = (phase + CGFloat(index) * 0.2).truncatingRemainder(dividingBy: 1)
        return 0.4 + 0.6 * abs(sin(t * .pi * 2))
    }
}
