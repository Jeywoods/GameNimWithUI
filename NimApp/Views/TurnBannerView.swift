import SwiftUI

internal struct TurnBannerView: View {
    let name: String

    var body: some View {
        HStack {
            Text("Сейчас ходит")
                .font(.subheadline)
            Spacer()
            Text(name)
                .font(.title3.weight(.semibold))
        }
        .foregroundColor(.white)
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(Theme.accent, in: RoundedRectangle(cornerRadius: 16))
    }
}
