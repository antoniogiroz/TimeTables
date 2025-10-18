//
//  ConfigurationView.swift
//  TimeTables
//
//  Created by Antonio Giroz on 15/10/25.
//

import SwiftUI

struct ConfigurationView: View {
    @Bindable var viewModel: GameViewModel
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        SettingsPicker(
                            icon: viewModel.selectedDifficulty == .easy ? "star.fill" : "star.leadinghalf.filled",
                            iconColor: .orange,
                            title: "Difficulty",
                            selection: $viewModel.selectedDifficulty,
                            options: Difficulty.allCases,
                            optionLabel: { $0.rawValue }
                        )

                        SettingsPicker(
                            icon: "number.circle.fill",
                            iconColor: .blue,
                            title: "Number of questions",
                            selection: $viewModel.selectedNumberOfQuestions,
                            options: viewModel.numberOfQuestions,
                            optionLabel: { "\($0)" }
                        )
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.background)
                            .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundStyle(.mint)
                            Text("Select multiplication table")
                                .font(.headline)
                        }
                        .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.timeTables, id: \.self) { table in
                                TableSelectionButton(
                                    table: table,
                                    isSelected: viewModel.selectedTable == table,
                                    action: { viewModel.selectedTable = table }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }

            VStack(spacing: 0) {
                Divider()

                Button {
                    viewModel.startGame()
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start Practice")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
                .buttonBorderShape(.roundedRectangle(radius: 14))
                .disabled(viewModel.selectedTable == 0)
                .padding()
                .background(.background)
            }
        }
        .navigationTitle("Time tables")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Initial state") {
    NavigationStack {
        ConfigurationView(viewModel: .previewConfiguration())
    }
}

#Preview("Normal mode selected") {
    NavigationStack {
        ConfigurationView(viewModel: .previewConfiguration(selectedTable: 7, selectedQuestions: 10, difficulty: .normal))
    }
}

#Preview("Easy mode - 20 questions") {
    NavigationStack {
        ConfigurationView(viewModel: .previewConfiguration(selectedTable: 12, selectedQuestions: 20, difficulty: .easy))
    }
}
