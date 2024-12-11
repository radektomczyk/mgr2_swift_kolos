import SwiftUI


// ZADANIE 3
struct WinScreenView: View {
    @ObservedObject var viewModel: MemoGameViewModel
    
    var body: some View {
        VStack {
            // PUNKT 1
            Text("Congratulations! You won in \(viewModel.moveCounter) moves!")
                .font(.headline)
            // PUNKT 2
            Text(viewModel.getMainCard()?.content ?? "🎉")
                .font(.system(size: 200))
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true))
            // PUNKT 3
            Button("RESTART") {
                viewModel.restart()
            }
            .foregroundStyle(viewModel.gameColor)
            .font(.system(size: Constants.FontSize.medium))
        }
    }
}
