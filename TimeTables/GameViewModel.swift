//
//  GameViewModel.swift
//  TimeTables
//
//  Created by Antonio Giroz on 11/10/25.
//

import Foundation

@Observable
class GameViewModel {
    let timeTables = Array(1...12)
    let numberOfQuestions = [5, 10, 20]

    var selectedNumberOfQuestions = 5
    var selectedTable: Int = 0
    var isPlaying = false

    var questionCount = 0
    var possibleAnswers = [Int]()
    var currentQuerstion = 0

    var score = 0
    var showingScore = false

    func startGame() {
        score = 0
        isPlaying = true
        askQuestion()

    }

    func askQuestion() {
        questionCount += 1
        currentQuerstion = Array(1...12).randomElement() ?? 1

        generateAnswers()
    }

    func generateAnswers() {
        var answers = [currentQuerstion * selectedTable]
        let limit = selectedTable * 12

        while answers.count < 3 {
            let newValue = Int.random(in: 1...limit)
            if !answers.contains(newValue) {
                answers.append(newValue)
            }
        }

        possibleAnswers = answers.shuffled()
    }

    func checkAswer(_ answer: Int) {
        if currentQuerstion * selectedTable == answer {
            score += 1
        }

        if questionCount == selectedNumberOfQuestions {
            gameOver()
            return
        }

        askQuestion()
    }

    func gameOver() {
        showingScore = true
        isPlaying = false
        questionCount = 0
        currentQuerstion = 0
        selectedTable = 0

    }
}

// MARK: - Preview Helpers
extension GameViewModel {
    /// Creates a GameViewModel configured for playing state
    static func previewPlaying(
        question: Int = 7,
        table: Int = 8,
        questionCount: Int = 3,
        totalQuestions: Int = 5,
        score: Int = 2
    ) -> GameViewModel {
        let vm = GameViewModel()
        vm.isPlaying = true
        vm.currentQuerstion = question
        vm.selectedTable = table
        vm.questionCount = questionCount
        vm.selectedNumberOfQuestions = totalQuestions
        vm.score = score

        // Generate realistic answers (correct answer + 2 wrong ones)
        let correctAnswer = question * table
        vm.possibleAnswers = [
            correctAnswer,
            correctAnswer + Int.random(in: 1...10),
            correctAnswer - Int.random(in: 1...10)
        ].shuffled()

        return vm
    }
}
