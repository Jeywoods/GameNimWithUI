import SwiftUI

internal struct SetupView: View {
    @State private var settings = GameSettings()
    let onStart: (GameSettings) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ним")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Theme.text)
                    Text("Настройте игру")
                        .font(.subheadline)
                        .foregroundColor(Theme.secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                card {
                    Picker("Режим", selection: $settings.mode) {
                        ForEach(GameMode.allCases, id: \.self) { mode in
                            Text(mode.title).tag(mode)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                card {
                    TextField(
                        settings.mode == .twoPlayers ? "Имя первого игрока" : "Ваше имя",
                        text: $settings.firstName
                    )
                    .textFieldStyle(.roundedBorder)
                    if settings.mode == .twoPlayers {
                        TextField("Имя второго игрока", text: $settings.secondName)
                            .textFieldStyle(.roundedBorder)
                    }
                }

                card {
                    Stepper("Кучек: \(settings.pileCount)", value: $settings.pileCount, in: 3...10)
                        .foregroundColor(Theme.text)
                }

                Button(action: { onStart(settings.normalized) }) {
                    Text("Начать игру")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 54)
                        .foregroundColor(.white)
                        .background(Theme.accent, in: RoundedRectangle(cornerRadius: 14))
                }
                .disabled(!settings.isValid)
                .opacity(settings.isValid ? 1 : 0.5)
            }
            .padding(20)
            .frame(maxWidth: 500)
            .frame(maxWidth: .infinity)
        }
        .background(Theme.background.ignoresSafeArea())
    }

    private func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 12, content: content)
            .padding(16)
            .background(Theme.card, in: RoundedRectangle(cornerRadius: 16))
    }
}
