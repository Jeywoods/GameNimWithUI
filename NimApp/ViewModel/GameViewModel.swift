import SwiftUI

@MainActor
internal final class GameViewModel: ObservableObject {
    @Published private(set) var state: GameState
    @Published private(set) var selectedPile: Int?
    @Published private(set) var takeCount: Int = 1
    @Published private(set) var lastMessage: String = ""
    @Published private(set) var winner: Player?

    private let formatter: StoneWordFormatter

    internal init(state: GameState, formatter: StoneWordFormatter = StoneWordFormatter()) {
        self.state = state
        self.formatter = formatter
    }

    internal var currentPlayer: Player {
        return state.currentPlayer
    }

    internal var isHumanTurn: Bool {
        return winner == nil && currentPlayer.isHuman
    }

    internal var maxTake: Int {
        guard let index = selectedPile else {
            return 0
        }
        return state.piles[index].stones
    }

    internal var canConfirm: Bool {
        return isHumanTurn && selectedPile != nil
    }

    internal func selectPile(_ index: Int) {
        guard isHumanTurn, state.piles.indices.contains(index), !state.piles[index].isEmpty else {
            return
        }
        selectedPile = index
        takeCount = 1
    }

    internal func increment() {
        guard canConfirm, takeCount < maxTake else {
            return
        }
        takeCount += 1
    }

    internal func decrement() {
        guard canConfirm, takeCount > 1 else {
            return
        }
        takeCount -= 1
    }

    internal func confirmMove() {
        guard canConfirm, let index = selectedPile else {
            return
        }
        perform(Move(pileIndex: index, count: takeCount))
    }

    private func perform(_ move: Move) {
        guard state.isValid(move) else {
            return
        }
        let player = state.currentPlayer
        state.apply(move)
        selectedPile = nil
        takeCount = 1
        lastMessage = message(player: player, move: move)

        if state.isOver {
            winner = player
            return
        }
        state.advanceTurn()
        scheduleComputerTurn()
    }

    private func scheduleComputerTurn() {
        guard let strategy = state.currentPlayer.strategy else {
            return
        }
        Task { [weak self] in
            try? await Task.sleep(nanoseconds: 800_000_000)
            guard let self else {
                return
            }
            let move = strategy.chooseMove(in: self.state)
            self.perform(move)
        }
    }

    private func message(player: Player, move: Move) -> String {
        let word = formatter.word(for: move.count)
        return "\(player.name) берёт \(move.count) \(word) из кучки \(move.pileIndex + 1)."
    }
}
