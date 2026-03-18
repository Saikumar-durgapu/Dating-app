import Foundation

@MainActor
final class DiscoverViewModel: ObservableObject {
    @Published var cards: [User] = []
    @Published var currentMatch: Match?
    @Published var isLoading = false

    private let repository: MatchRepositoryProtocol

    init(repository: MatchRepositoryProtocol) {
        self.repository = repository
    }

    func load(for userID: String) async {
        isLoading = true
        defer { isLoading = false }
        cards = (try? await repository.discoverCandidates(userID: userID)) ?? []
    }

    func likeTopCard(userID: String) async {
        guard let card = cards.first else { return }
        defer { cards.removeFirst() }
        do {
            if case .matched(let match) = try await repository.like(from: userID, to: card.id) {
                currentMatch = match
            }
        } catch {
            // Add toast/error telemetry in production.
        }
    }

    func passTopCard(userID: String) async {
        guard let card = cards.first else { return }
        try? await repository.pass(from: userID, targetID: card.id)
        cards.removeFirst()
    }
}
