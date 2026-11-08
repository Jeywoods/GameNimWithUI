import SwiftUI

internal struct PileRowView: View {
    let number: Int
    let stones: Int
    let markedCount: Int
    let isSelected: Bool
    let onTap: () -> Void

    private let columns = [GridItem(.adaptive(minimum: 16, maximum: 16), spacing: 6)]

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Text("Кучка \(number)")
                    .font(.subheadline.weight(.semibold))
                    .frame(width: 70, alignment: .leading)
                LazyVGrid(columns: columns, alignment: .leading, spacing: 6) {
                    ForEach(0..<stones, id: \.self) { index in
                        StoneView(isMarked: index >= stones - markedCount)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(stones)")
                    .font(.headline.weight(.bold))
            }
            .foregroundColor(Theme.text)
            .padding(16)
            .frame(minHeight: 56)
            .background(Theme.card, in: RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Theme.accent : Color.clear, lineWidth: 2)
            )
            .opacity(stones == 0 ? 0.5 : 1)
        }
        .buttonStyle(.plain)
    }
}
