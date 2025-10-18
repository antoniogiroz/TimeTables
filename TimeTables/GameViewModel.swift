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
    // MARK: - Constants
    private let maxTimesTable = 12
    private let numberOfAnswerOptions = 3

    // MARK: - Configuration
    let timeTables = Array(1...12)
    let numberOfQuestions = [5, 10, 20]

    var selectedNumberOfQuestions = 5
    var selectedTable: Int = 0
    var selectedDifficulty: Difficulty = .easy

    // MARK: - Game State
    var isPlaying = false
    var showingResults = false

    var questionCount = 0
    var possibleAnswers = [Int]()
    var currentQuestion = 0
    var userAnswer: String = ""

    var score = 0

    var correctAnswer: Int {
        currentQuestion * selectedTable
    }

    // MARK: - Game Flow
    func startGame() {
        score = 0
        isPlaying = true
        askQuestion()
    }

    func askQuestion() {
        questionCount += 1
        currentQuestion = Array(1...maxTimesTable).randomElement() ?? 1
        userAnswer = ""

        if selectedDifficulty == .easy {
            generateAnswers()
        }
    }

    func generateAnswers() {
        guard selectedTable > 0 else { return }

        var answers = [correctAnswer]
        let limit = selectedTable * maxTimesTable

        while answers.count < numberOfAnswerOptions {
            let newValue = Int.random(in: 1...limit)
            if !answers.contains(newValue) {
                answers.append(newValue)
            }
        }

        possibleAnswers = answers.shuffled()
    }

    func checkAnswer(_ answer: Int) {
        if correctAnswer == answer {
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
        checkAnswer(answer)
    }

    // MARK: - Number Pad Input
    func appendDigit(_ digit: String) {
        userAnswer += digit
    }

    func deleteLastDigit() {
        if !userAnswer.isEmpty {
            userAnswer.removeLast()
        }
    }

    // MARK: - Game Control
    func gameOver() {
        showingResults = true
    }

    func cancelGame() {
        resetGameState()
        isPlaying = false
    }

    func restartGame() {
        resetGameState()
        askQuestion()
    }

    func backToMenu() {
        resetGameState()
        isPlaying = false
        selectedTable = 0
    }

    // MARK: - Private Helpers
    private func resetGameState() {
        showingResults = false
        questionCount = 0
        currentQuestion = 0
        score = 0
        userAnswer = ""
        possibleAnswers = []
    }
}

// MARK: - Preview Helpers
extension GameViewModel {
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
        vm.currentQuestion = question
        vm.selectedTable = table
        vm.questionCount = questionCount
        vm.selectedNumberOfQuestions = totalQuestions
        vm.score = score
        vm.selectedDifficulty = difficulty

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
