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
        VStack(spacing: 20) {
            Text(viewModel.userAnswer.isEmpty ? "___" : viewModel.userAnswer)
                .font(.system(size: 56, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
                .frame(minWidth: 180)
                .frame(height: 80)
                .padding(.horizontal, 24)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.15))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray.opacity(0.3), lineWidth: 2)
                        }
                }

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(1...9, id: \.self) { number in
                    Button {
                        viewModel.appendDigit("\(number)")
                    } label: {
                        Text("\(number)")
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .frame(height: 64)
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .buttonBorderShape(.roundedRectangle(radius: 12))
                }

                Button {
                    viewModel.deleteLastDigit()
                } label: {
                    Image(systemName: "delete.backward.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                }
                .buttonStyle(.bordered)
                .tint(.orange)
                .buttonBorderShape(.roundedRectangle(radius: 12))

                Button {
                    viewModel.appendDigit("0")
                } label: {
                    Text("0")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                }
                .buttonStyle(.bordered)
                .tint(.mint)
                .buttonBorderShape(.roundedRectangle(radius: 12))

                Button {
                    viewModel.submitAnswer()
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .buttonBorderShape(.roundedRectangle(radius: 12))
                .disabled(viewModel.userAnswer.isEmpty)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NumberPadView(viewModel: .previewPlaying())
}
