//
//  QuestionDisplay.swift
//  TimeTables
//
//  Created by Antonio Giroz on 18/10/25.
//

import SwiftUI

struct QuestionDisplay: View {
    let question: Int
    let table: Int

    var body: some View {
        VStack(spacing: 12) {
            Text("\(question) × \(table) = ?")
                .font(.system(size: 72, weight: .heavy, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.mint, .cyan],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 40)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: [.mint.opacity(0.15), .cyan.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(.mint.opacity(0.3), lineWidth: 2)
                }
                .shadow(color: .mint.opacity(0.2), radius: 8, y: 4)
        }
    }
}

#Preview {
    QuestionDisplay(question: 7, table: 8)
        .padding()
}
