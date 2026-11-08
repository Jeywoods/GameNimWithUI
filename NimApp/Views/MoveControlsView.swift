import SwiftUI

internal struct MoveControlsView: View {
    let title: String
    let count: Int
    let isActive: Bool
    let onDecrement: () -> Void
    let onIncrement: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(Theme.secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                stepButton("−", label: "Меньше", action: onDecrement)
                Spacer()
                Text("\(count)")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Theme.text)
                Spacer()
                stepButton("+", label: "Больше", action: onIncrement)
            }
            Button(action: onConfirm) {
                Text("Сделать ход")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 54)
                    .foregroundColor(.white)
                    .background(Theme.accent, in: RoundedRectangle(cornerRadius: 14))
            }
            .disabled(!isActive)
        }
        .padding(18)
        .background(Theme.card, in: RoundedRectangle(cornerRadius: 16))
        .opacity(isActive ? 1 : 0.6)
    }

    private func stepButton(_ symbol: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(symbol)
                .font(.system(size: 26, weight: .semibold))
                .frame(width: 52, height: 52)
                .foregroundColor(Theme.accent)
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(Theme.accent, lineWidth: 2))
        }
        .accessibilityLabel(label)
        .disabled(!isActive)
    }
}
