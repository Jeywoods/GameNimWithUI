internal struct GameState {
    internal private(set) var piles: [Pile]
    internal let players: [Player]
    internal private(set) var currentPlayerIndex: Int

    internal init(players: [Player], piles: [Pile]) {
        self.players = players
        self.piles = piles
        self.currentPlayerIndex = 0
    }

    internal static func makeRandom(players: [Player], pileCount: Int) -> GameState {
        let piles = (0..<pileCount).map { _ in
            Pile(stones: Int.random(in: 3...7))
        }
        return GameState(players: players, piles: piles)
    }

    internal var currentPlayer: Player {
        return players[currentPlayerIndex]
    }

    internal var isOver: Bool {
        return piles.allSatisfy { $0.isEmpty }
    }

    internal var nonEmptyPileIndices: [Int] {
        return piles.indices.filter { !piles[$0].isEmpty }
    }

    internal func isValid(_ move: Move) -> Bool {
        guard piles.indices.contains(move.pileIndex) else {
            return false
        }
        let stones = piles[move.pileIndex].stones
        return move.count >= 1 && move.count <= stones
    }

    internal mutating func apply(_ move: Move) {
        piles[move.pileIndex].remove(move.count)
    }

    internal mutating func advanceTurn() {
        currentPlayerIndex = (currentPlayerIndex + 1) % players.count
    }
}
