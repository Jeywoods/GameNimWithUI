internal struct RandomComputerStrategy: MoveStrategy {
    internal init() {}

    internal func chooseMove(in state: GameState) -> Move {
        let pileIndex = state.nonEmptyPileIndices.randomElement() ?? 0
        let stones = state.piles[pileIndex].stones
        let count = Int.random(in: 1...max(1, stones))
        return Move(pileIndex: pileIndex, count: count)
    }
}
