import SwiftUI

struct PremiumPlaceholderView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Spark Premium")
                .font(.largeTitle.bold())
            Text("Boosts, read receipts, advanced filters coming soon.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
