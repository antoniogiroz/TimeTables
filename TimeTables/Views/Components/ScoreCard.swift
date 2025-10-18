//
//  ScoreCard.swift
//  TimeTables
//
//  Created by Antonio Giroz on 18/10/25.
//

import SwiftUI

struct ScoreCard: View {
    let correct: Int
    let wrong: Int
    let table: Int

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                HStack {
                    Label("Correct", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                    Spacer()
                    Text("\(correct)")
                        .font(.headline.monospacedDigit())
                }

                Divider()

                HStack {
                    Label("Wrong", systemImage: "xmark.circle.fill")
                        .foregroundStyle(.red)
                    Spacer()
                    Text("\(wrong)")
                        .font(.headline.monospacedDigit())
                }

                Divider()

                HStack {
                    Label("Table", systemImage: "multiply.circle.fill")
                        .foregroundStyle(.mint)
                    Spacer()
                    Text("\(table)× table")
                        .font(.headline)
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.background)
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ScoreCard(correct: 8, wrong: 2, table: 7)
}
