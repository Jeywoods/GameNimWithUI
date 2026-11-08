internal enum GameMode: CaseIterable {
    case versusComputer
    case twoPlayers

    internal var title: String {
        switch self {
        case .versusComputer:
            return "Против компьютера"
        case .twoPlayers:
            return "Вдвоём"
        }
    }
}
