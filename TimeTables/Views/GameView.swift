//
//  GameView.swift
//  TimeTables
//
//  Created by Antonio Giroz on 15/10/25.
//

import SwiftUI

struct GameView: View {
    @Bindable var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 24) {
            VStack() {
                Text("\(viewModel.currentQuerstion) x \(viewModel.selectedTable)")
                    .font(.largeTitle)
                    .foregroundStyle(.teal)
                    .frame(minWidth: 200)
                    .padding()
                    .border(.teal, width: 3)
                    .tint(.teal)
            }

            if viewModel.selectedDifficulty == .easy {
                VStack {
                    ForEach(viewModel.possibleAnswers, id: \.self) { number in
                        Button {
                            viewModel.checkAswer(number)
                        } label: {
                            Text("\(number)")
                                .frame(height: 80)
                                .font(.title)
                                .scaledToFit()
                        }
                        .buttonStyle(.glass)
                        .buttonSizing(.flexible)
                        .buttonBorderShape(.roundedRectangle(radius: 12))
                    }
                }
            } else {
                NumberPadView(viewModel: viewModel)
            }
        }
        .padding()
        .navigationTitle("Question \(viewModel.questionCount)/\(viewModel.selectedNumberOfQuestions)")
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
