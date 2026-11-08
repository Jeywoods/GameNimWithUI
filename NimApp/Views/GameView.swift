import SwiftUI

internal struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    let onNewGame: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header
                TurnBannerView(name: viewModel.currentPlayer.name)
                pilesList
                MoveControlsView(
                    title: controlsTitle,
                    count: viewModel.takeCount,
                    isActive: viewModel.canConfirm,
                    onDecrement: viewModel.decrement,
                    onIncrement: viewModel.increment,
                    onConfirm: viewModel.confirmMove
                )
                Text(viewModel.lastMessage)
                    .font(.footnote)
                    .foregroundColor(Theme.secondaryText)
                    .multilineTextAlignment(.center)
            }
            .padding(20)
            .frame(maxWidth: 500)
            .frame(maxWidth: .infinity)
        }
        .background(Theme.background.ignoresSafeArea())
        .alert(
            "Победитель: \(viewModel.winner?.name ?? "")",
            isPresented: .constant(viewModel.winner != nil)
        ) {
            Button("Новая игра", action: onNewGame)
        } message: {
            Text("Все кучки пусты.")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Ним")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(Theme.text)
            Text("Побеждает тот, кто забрал последний камень")
                .font(.subheadline)
                .foregroundColor(Theme.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var pilesList: some View {
        VStack(spacing: 10) {
            ForEach(Array(viewModel.state.piles.enumerated()), id: \.offset) { offset, pile in
                PileRowView(
                    number: offset + 1,
                    stones: pile.stones,
                    markedCount: viewModel.selectedPile == offset ? viewModel.takeCount : 0,
                    isSelected: viewModel.selectedPile == offset,
                    onTap: { viewModel.selectPile(offset) }
                )
            }
        }
    }

    private var controlsTitle: String {
        if !viewModel.currentPlayer.isHuman {
            return "Компьютер думает…"
        }
        guard let index = viewModel.selectedPile else {
            return "Выберите кучку"
        }
        return "Из кучки \(index + 1) взять камней"
    }
}
