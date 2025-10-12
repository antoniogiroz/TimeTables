//
//  GameViewModel.swift
//  TimeTables
//
//  Created by Antonio Giroz on 11/10/25.
//

import Foundation

extension ContentView {
    @Observable
    class ViewModel {
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
            } else {
                score = score > 0 ? score - 1 : 0
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
}
