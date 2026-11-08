internal struct StoneWordFormatter {
    internal init() {}

    internal func word(for count: Int) -> String {
        let lastTwo = count % 100
        let last = count % 10
        if lastTwo >= 11 && lastTwo <= 14 {
            return "камней"
        }
        if last == 1 {
            return "камень"
        }
        if last >= 2 && last <= 4 {
            return "камня"
        }
        return "камней"
    }
}
