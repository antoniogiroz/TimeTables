//
//  ContentView.swift
//  TimeTables
//
//  Created by Antonio Giroz on 8/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = GameViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.isPlaying {
                GameView(viewModel: viewModel)
            } else {
                ConfigurationView(viewModel: viewModel)
            }
        }
        .alert("Game Over", isPresented: $viewModel.showingScore) {

        } message: {
            Text("Success: \(viewModel.score) - Wrong: \(viewModel.selectedNumberOfQuestions - viewModel.score)")
        }
    }
}

#Preview {
    ContentView()
}
