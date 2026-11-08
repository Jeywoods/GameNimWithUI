internal struct Move: Equatable {
    internal let pileIndex: Int
    internal let count: Int

    internal init(pileIndex: Int, count: Int) {
        self.pileIndex = pileIndex
        self.count = count
    }
}
