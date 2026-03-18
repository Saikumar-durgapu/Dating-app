import SwiftUI

struct EmptyStateView: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 10) {
            Text(title).font(.title3.bold())
            Text(subtitle).font(.subheadline).multilineTextAlignment(.center).foregroundStyle(.secondary)
        }
        .padding()
    }
}
