//
//  NumberPadView.swift
//  TimeTables
//
//  Created by Antonio Giroz on 15/10/25.
//

import SwiftUI

struct NumberPadView: View {
    @Bindable var viewModel: GameViewModel

    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(spacing: 24) {
            // Answer display
            VStack {
                Text(viewModel.userAnswer.isEmpty ? "?" : viewModel.userAnswer)
                    .font(.system(size: 60, weight: .bold))
                    .foregroundStyle(.teal)
                    .frame(minWidth: 200, minHeight: 80)
                    .padding()
                    .border(.teal, width: 3)
            }

            // Number pad grid
            LazyVGrid(columns: columns, spacing: 12) {
                // Numbers 1-9
                ForEach(1...9, id: \.self) { number in
                    Button {
                        viewModel.appendDigit("\(number)")
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

                // Delete button
                Button {
                    viewModel.deleteLastDigit()
                } label: {
                    Image(systemName: "delete.left")
                        .frame(height: 80)
                        .font(.title)
                        .scaledToFit()
                }
                .buttonStyle(.glass)
                .buttonSizing(.flexible)
                .tint(.orange)
                .buttonBorderShape(.roundedRectangle(radius: 12))

                // Zero button
                Button {
                    viewModel.appendDigit("0")
                } label: {
                    Text("0")
                        .frame(height: 80)
                        .font(.title)
                        .scaledToFit()
                }
                .buttonStyle(.glass)
                .buttonSizing(.flexible)
                .buttonBorderShape(.roundedRectangle(radius: 12))

                // Submit button
                Button {
                    viewModel.submitAnswer()
                } label: {
                    Image(systemName: "checkmark")
                        .frame(height: 80)
                        .font(.title)
                        .scaledToFit()
                }
                .buttonStyle(.glassProminent)
                .buttonSizing(.flexible)
                .tint(.green)
                .buttonBorderShape(.roundedRectangle(radius: 12))
                .disabled(viewModel.userAnswer.isEmpty)
            }
        }
    }
}

#Preview {
    NumberPadView(viewModel: .previewPlaying())
}
