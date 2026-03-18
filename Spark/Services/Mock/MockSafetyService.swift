import Foundation

struct MockSafetyService: SafetyServiceProtocol {
    func block(userID: String, blockedUserID: String) async throws {
        await MockStore.shared.addBlock(BlockedUser(id: UUID().uuidString, userID: userID, blockedUserID: blockedUserID, createdAt: .now))
    }

    func report(_ report: Report) async throws {}

    func deleteAccount(userID: String) async throws {}
}
