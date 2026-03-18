import Foundation

struct MockDiscoveryService: DiscoveryServiceProtocol {
    func fetchCandidates(for userID: String) async throws -> [User] {
        let store = MockStore.shared
        let users = await store.allUsers()
        let blocks = await store.allBlocks()
        let passes = await store.allPasses()
        let matches = await store.allMatches()

        let blockedIDs = Set(blocks.filter { $0.userID == userID }.map(\.blockedUserID))
        let matchedIDs = Set(matches.flatMap { [$0.userA, $0.userB] }.filter { $0 != userID })

        return users
            .filter { $0.id != userID }
            .filter { !blockedIDs.contains($0.id) }
            .filter { !passes.contains("\(userID):\($0.id)") }
            .filter { !matchedIDs.contains($0.id) }
            .sorted { lhs, rhs in
                lhs.profile.interests.count > rhs.profile.interests.count
            }
    }

    func pass(on userID: String, by actorID: String) async throws {
        await MockStore.shared.addPass(actorID: actorID, targetID: userID)
    }
}
