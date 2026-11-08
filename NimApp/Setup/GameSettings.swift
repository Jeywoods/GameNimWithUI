import Foundation

internal struct GameSettings {
    internal var mode: GameMode = .versusComputer
    internal var firstName: String = ""
    internal var secondName: String = ""
    internal var pileCount: Int = 3

    internal var isValid: Bool {
        let firstFilled = !trimmed(firstName).isEmpty
        let secondFilled = mode == .versusComputer || !trimmed(secondName).isEmpty
        return firstFilled && secondFilled
    }

    internal var normalized: GameSettings {
        var copy = self
        copy.firstName = trimmed(firstName)
        copy.secondName = trimmed(secondName)
        return copy
    }

    private func trimmed(_ text: String) -> String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
