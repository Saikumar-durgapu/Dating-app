import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm: DiscoverViewModel

    init() {
        _vm = StateObject(wrappedValue: DiscoverViewModel(repository: MatchRepository(discovery: ServiceContainer.mock.discoveryService, matching: ServiceContainer.mock.matchService)))
    }

    var body: some View {
        ZStack {
            if vm.isLoading {
                LoadingStateView(message: "Finding your spark...")
            } else if let first = vm.cards.first {
                VStack {
                    ProfileCardView(user: first)
                    HStack(spacing: 20) {
                        SparkButton(title: "Pass", style: .secondary) {
                            Task { await vm.passTopCard(userID: appState.currentUser?.id ?? SampleData.currentUser.id) }
                        }
                        SparkButton(title: "Like") {
                            Task { await vm.likeTopCard(userID: appState.currentUser?.id ?? SampleData.currentUser.id) }
                        }
                    }
                }
                .padding()
            } else {
                EmptyStateView(title: "No more profiles", subtitle: "Check back soon for more nearby people.")
            }
        }
        .task {
            await vm.load(for: appState.currentUser?.id ?? SampleData.currentUser.id)
        }
        .sheet(item: $vm.currentMatch) { match in
            MatchPopupView(match: match)
        }
    }
}
