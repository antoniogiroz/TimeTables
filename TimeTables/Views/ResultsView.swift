//
//  ResultsView.swift
//  TimeTables
//
//  Created by Antonio Giroz on 15/10/25.
//

import SwiftUI

struct ResultsView: View {
    @Bindable var viewModel: GameViewModel

    var percentage: Double {
        Double(viewModel.score) / Double(viewModel.selectedNumberOfQuestions) * 100
    }

    var emoji: String {
        switch percentage {
        case 90...100: return "🌟"
        case 70..<90: return "🎉"
        case 50..<70: return "👍"
        default: return "💪"
        }
    }

    var message: String {
        switch percentage {
        case 90...100: return "Outstanding!"
        case 70..<90: return "Great job!"
        case 50..<70: return "Good effort!"
        default: return "Keep practicing!"
        }
    }

    var body: some View {
        VStack(spacing: 32) {
            Text(emoji)
                .font(.system(size: 100))
                .padding(.bottom, 8)

            Text(message)
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.mint, .cyan],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            ScoreCard(
                correct: viewModel.score,
                wrong: viewModel.selectedNumberOfQuestions - viewModel.score,
                table: viewModel.selectedTable
            )

            Spacer()

            VStack(spacing: 12) {
                Button {
                    viewModel.restartGame()
                } label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Practice Again")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
                .buttonBorderShape(.roundedRectangle(radius: 14))

                Button {
                    viewModel.backToMenu()
                } label: {
                    Text("Back to Menu")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                }
                .buttonStyle(.bordered)
                .tint(.secondary)
                .buttonBorderShape(.roundedRectangle(radius: 14))
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle("Results")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview("Perfect score") {
    NavigationStack {
        ResultsView(
            viewModel: GameViewModel.previewPlaying(table: 7, totalQuestions: 10, score: 10)
        )
    }
}

#Preview("Good score") {
    NavigationStack {
        ResultsView(
            viewModel: GameViewModel.previewPlaying(table: 12, totalQuestions: 10, score: 7)
        )
    }
}

#Preview("Needs practice") {
    NavigationStack {
        ResultsView(
            viewModel: GameViewModel.previewPlaying(table: 5, totalQuestions: 10, score: 3)
        )
    }
}
