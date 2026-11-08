import SwiftUI

struct ContentView: View {
    @State private var game: GameViewModel?
    private let factory = GameFactory()

    var body: some View {
        if let current = game {
            GameView(viewModel: current, onNewGame: { self.game = nil })
        } else {
            SetupView { settings in
                self.game = factory.makeViewModel(settings: settings)
            }
        }
    }
}
