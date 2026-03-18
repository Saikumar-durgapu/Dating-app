import SwiftUI

struct MatchesListView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm: MatchesViewModel

    init() {
        _vm = StateObject(wrappedValue: MatchesViewModel(repository: MatchRepository(discovery: ServiceContainer.mock.discoveryService, matching: ServiceContainer.mock.matchService)))
    }

    var body: some View {
        NavigationStack {
            List(vm.matches) { match in
                NavigationLink {
                    ChatView(match: match)
                } label: {
                    VStack(alignment: .leading) {
                        Text("Match \(match.id.prefix(6))")
                        if let preview = match.lastMessagePreview {
                            Text(preview).font(.footnote).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .overlay {
                if vm.matches.isEmpty {
                    EmptyStateView(title: "No matches yet", subtitle: "Keep swiping to create your first connection.")
                }
            }
            .navigationTitle("Matches")
        }
        .task {
            await vm.load(userID: appState.currentUser?.id ?? SampleData.currentUser.id)
        }
    }
}
