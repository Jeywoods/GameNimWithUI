import SwiftUI

internal struct StoneView: View {
    let isMarked: Bool

    var body: some View {
        Circle()
            .fill(isMarked ? Color.clear : Theme.accent)
            .overlay(Circle().stroke(Theme.accent, lineWidth: 2))
            .frame(width: 16, height: 16)
    }
}
