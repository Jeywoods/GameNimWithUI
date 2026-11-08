internal struct Pile {
    internal private(set) var stones: Int

    internal init(stones: Int) {
        self.stones = stones
    }

    internal var isEmpty: Bool {
        return stones == 0
    }

    internal mutating func remove(_ count: Int) {
        stones -= count
    }
}
