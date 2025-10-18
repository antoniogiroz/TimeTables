//
//  TableSelectionButton.swift
//  TimeTables
//
//  Created by Antonio Giroz on 18/10/25.
//

import SwiftUI

struct TableSelectionButton: View {
    let table: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text("\(table)")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                Text("× table")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 70)
        }
        .buttonStyle(.bordered)
        .tint(isSelected ? .pink : .mint)
        .buttonBorderShape(.roundedRectangle(radius: 12))
        .overlay {
            if isSelected {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.pink, lineWidth: 3)
            }
        }
    }
}

#Preview {
    HStack {
        TableSelectionButton(table: 7, isSelected: true, action: {})
        TableSelectionButton(table: 8, isSelected: false, action: {})
    }
    .padding()
}
