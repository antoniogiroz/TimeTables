//
//  ContentView.swift
//  TimeTables
//
//  Created by Antonio Giroz on 8/10/25.
//

import SwiftUI

struct ContentView: View {
    let timeTables = Array(1...12)
    let numberOfQuestions = [5, 10, 20]
    
    @State private var selectedNumberOfQuestions = 5
    @State private var selectedTable: Int = 0
    @State private var playing = false
    
    @State private var questionCount = 0
    @State private var possibleAnswers = [Int()]
    @State private var currentQuerstion = 0
    
    @State private var score = 0
    @State private var showingScore = false
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    
    var body: some View {
        NavigationStack {
            if playing {
                VStack(spacing: 24) {
                    VStack() {
                        Text("\(currentQuerstion) x \(selectedTable)")
                            .font(.largeTitle)
                            .foregroundStyle(.teal)
                            .frame(minWidth: 200)
                            .padding()
                            .border(.teal, width: 3)
                            .tint(.teal)                        
                    }
                    
                    
                    VStack {
                        ForEach(possibleAnswers, id: \.self) { number in
                            Button {
                                checkAswer(number)
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
                }
                .padding()
                .navigationTitle("Question \(questionCount)/\(selectedNumberOfQuestions)")
            } else {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading) {
                        Section("Number of questions") {
                            Picker(selection: $selectedNumberOfQuestions) {
                                ForEach(numberOfQuestions, id: \.self) {
                                    Text("\($0)")
                                }
                            } label: {
                                Text("Number of questions")
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    VStack {
                        Text("Select a table to practice")
                            .font(.title2)
                        
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(timeTables, id: \.self) { table in
                                Button {
                                    selectedTable = table
                                } label: {
                                    Text("\(table)")
                                        .frame(height: 80)
                                        .font(.title)
                                        .scaledToFit()
                                }
                                .buttonStyle(.glass)
                                .buttonSizing(.flexible)
                                .tint(selectedTable == table ? .pink : .teal)
                                .buttonBorderShape(.roundedRectangle(radius: 12))
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        startGame()
                    } label: {
                        Text("Start!")
                            .frame(height: 40)
                            .font(.title)
                            .scaledToFit()
                    }
                    .buttonStyle(.glassProminent)
                    .buttonSizing(.flexible)
                    .tint(.pink)
                    .buttonBorderShape(.roundedRectangle(radius: 12))
                    .disabled(selectedTable == 0)
                    
                }
                .padding()
                .navigationTitle("Time tables")
            }
        }
        .alert("Game Over", isPresented: $showingScore) {
            
        } message: {
            Text("Success: \(score) - Wrong: \(selectedNumberOfQuestions - score)")
        }
    }
    
    func startGame() {
        score = 0
        playing = true
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
        playing = false
        questionCount = 0
        currentQuerstion = 0
        selectedTable = 0
        
    }
}
#Preview {
    ContentView()
}
