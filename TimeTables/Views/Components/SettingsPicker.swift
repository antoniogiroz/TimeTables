//
//  SettingsPicker.swift
//  TimeTables
//
//  Created by Antonio Giroz on 18/10/25.
//

import SwiftUI

struct SettingsPicker<T: Hashable>: View {
    let icon: String
    let iconColor: Color
    let title: String
    let selection: Binding<T>
    let options: [T]
    let optionLabel: (T) -> String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(iconColor)
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

            Picker(title, selection: selection) {
                ForEach(options, id: \.self) { option in
                    Text(optionLabel(option)).tag(option)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    SettingsPicker(
        icon: "star.fill",
        iconColor: .orange,
        title: "Difficulty",
        selection: .constant(Difficulty.easy),
        options: Difficulty.allCases,
        optionLabel: { $0.rawValue }
    )
    .padding()
}
