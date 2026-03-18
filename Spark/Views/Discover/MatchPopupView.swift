import SwiftUI

struct MatchPopupView: View {
    let match: Match
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 18) {
            Text("It's a Match!").font(.largeTitle.bold())
            Text("You both liked each other.")
            SparkButton(title: "Keep Swiping") { dismiss() }
        }
        .padding()
        .presentationDetents([.medium])
    }
}
