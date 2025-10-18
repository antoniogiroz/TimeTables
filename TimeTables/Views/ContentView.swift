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
            ConfigurationView(viewModel: viewModel)
                .navigationDestination(isPresented: $viewModel.isPlaying) {
                    GameView(viewModel: viewModel)
                        .navigationDestination(isPresented: $viewModel.showingResults) {
                            ResultsView(viewModel: viewModel)
                        }
                }
        }
    }
}

#Preview {
    ContentView()
}
