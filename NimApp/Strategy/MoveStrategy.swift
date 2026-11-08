internal protocol MoveStrategy {
    func chooseMove(in state: GameState) -> Move
}
