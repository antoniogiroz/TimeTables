//
//  GameView.swift
//  TimeTables
//
//  Created by Antonio Giroz on 15/10/25.
//

import SwiftUI

struct GameView: View {
    @Bindable var viewModel: GameViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 40) {
            QuestionDisplay(
                question: viewModel.currentQuestion,
                table: viewModel.selectedTable
            )

            Spacer()

            if viewModel.selectedDifficulty == .easy {
                VStack(spacing: 16) {
                    ForEach(viewModel.possibleAnswers, id: \.self) { number in
                        Button {
                            viewModel.checkAnswer(number)
                        } label: {
                            Text("\(number)")
                                .font(.system(size: 32, weight: .semibold, design: .rounded))
                                .frame(maxWidth: .infinity)
                                .frame(height: 64)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                        .buttonBorderShape(.roundedRectangle(radius: 12))
                    }
                }
                .padding(.horizontal, 40)
            } else {
                NumberPadView(viewModel: viewModel)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Question \(viewModel.questionCount)/\(viewModel.selectedNumberOfQuestions)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.cancelGame()
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}

#Preview("Easy mode") {
    NavigationStack {
        GameView(viewModel: .previewPlaying())
    }
}

#Preview("Normal mode") {
    NavigationStack {
        GameView(viewModel: .previewPlaying(difficulty: .normal))
    }
}

#Preview("Normal mode - with answer") {
    let vm = GameViewModel.previewPlaying(difficulty: .normal)
    vm.userAnswer = "56"

    return NavigationStack {
        GameView(viewModel: vm)
    }
}
