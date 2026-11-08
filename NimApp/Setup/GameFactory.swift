internal struct GameFactory {
    internal init() {}

    @MainActor
    internal func makeViewModel(settings: GameSettings) -> GameViewModel {
        let players = makePlayers(settings: settings)
        let state = GameState.makeRandom(players: players, pileCount: settings.pileCount)
        return GameViewModel(state: state)
    }

    private func makePlayers(settings: GameSettings) -> [Player] {
        switch settings.mode {
        case .twoPlayers:
            return [
                Player(name: settings.firstName),
                Player(name: settings.secondName)
            ]
        case .versusComputer:
            return [
                Player(name: settings.firstName),
                Player(name: "Компьютер", strategy: RandomComputerStrategy())
            ]
        }
    }
}
