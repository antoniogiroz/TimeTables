//
//  GameViewModel.swift
//  TimeTables
//
//  Created by Antonio Giroz on 11/10/25.
//

import Foundation

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case normal = "Normal"
}

@Observable
class GameViewModel {
    let timeTables = Array(1...12)
    let numberOfQuestions = [5, 10, 20]

    var selectedNumberOfQuestions = 5
    var selectedTable: Int = 0
    var selectedDifficulty: Difficulty = .easy
    var isPlaying = false

    var questionCount = 0
    var possibleAnswers = [Int]()
    var currentQuerstion = 0
    var userAnswer: String = ""

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
        userAnswer = ""

        // Only generate answers for easy mode
        if selectedDifficulty == .easy {
            generateAnswers()
        }
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

    func submitAnswer() {
        guard let answer = Int(userAnswer) else { return }
        checkAswer(answer)
    }

    func appendDigit(_ digit: String) {
        userAnswer += digit
    }

    func deleteLastDigit() {
        if !userAnswer.isEmpty {
            userAnswer.removeLast()
        }
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
        score: Int = 2,
        difficulty: Difficulty = .easy
    ) -> GameViewModel {
        let vm = GameViewModel()
        vm.isPlaying = true
        vm.currentQuerstion = question
        vm.selectedTable = table
        vm.questionCount = questionCount
        vm.selectedNumberOfQuestions = totalQuestions
        vm.score = score
        vm.selectedDifficulty = difficulty

        // Generate realistic answers for easy mode
        if difficulty == .easy {
            let correctAnswer = question * table
            vm.possibleAnswers = [
                correctAnswer,
                correctAnswer + Int.random(in: 1...10),
                correctAnswer - Int.random(in: 1...10)
            ].shuffled()
        }

        return vm
    }

    /// Creates a GameViewModel configured for configuration state
    static func previewConfiguration(
        selectedTable: Int = 0,
        selectedQuestions: Int = 5,
        difficulty: Difficulty = .easy
    ) -> GameViewModel {
        let vm = GameViewModel()
        vm.isPlaying = false
        vm.selectedTable = selectedTable
        vm.selectedNumberOfQuestions = selectedQuestions
        vm.selectedDifficulty = difficulty
        return vm
    }
}
