import Foundation

@MainActor
final class MatchesViewModel: ObservableObject {
    @Published var matches: [Match] = []

    private let repository: MatchRepositoryProtocol

    init(repository: MatchRepositoryProtocol) {
        self.repository = repository
    }

    func load(userID: String) async {
        matches = (try? await repository.matches(userID: userID)) ?? []
    }
}
