//
//  ConfigurationView.swift
//  TimeTables
//
//  Created by Antonio Giroz on 15/10/25.
//

import SwiftUI

struct ConfigurationView: View {
    @Bindable var viewModel: GameViewModel
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading) {
                Section("Number of questions") {
                    Picker(selection: $viewModel.selectedNumberOfQuestions) {
                        ForEach(viewModel.numberOfQuestions, id: \.self) {
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
                    ForEach(viewModel.timeTables, id: \.self) { table in
                        Button {
                            viewModel.selectedTable = table
                        } label: {
                            Text("\(table)")
                                .frame(height: 80)
                                .font(.title)
                                .scaledToFit()
                        }
                        .buttonStyle(.glass)
                        .buttonSizing(.flexible)
                        .tint(viewModel.selectedTable == table ? .pink : .teal)
                        .buttonBorderShape(.roundedRectangle(radius: 12))
                    }
                }
            }

            Spacer()

            Button {
                viewModel.startGame()
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
            .disabled(viewModel.selectedTable == 0)
        }
        .padding()
        .navigationTitle("Time tables")
    }
}

#Preview {
    NavigationStack {
        ConfigurationView(viewModel: GameViewModel())
    }
}
