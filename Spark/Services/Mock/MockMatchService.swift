import Foundation

struct MockMatchService: MatchServiceProtocol {
    func sendLike(from fromUserID: String, to toUserID: String) async throws -> MatchResult {
        let store = MockStore.shared
        let likes = await store.allLikes()

        guard !likes.contains(where: { $0.fromUserID == fromUserID && $0.toUserID == toUserID }) else {
            return .pendingLike
        }

        let reverse = likes.contains { $0.fromUserID == toUserID && $0.toUserID == fromUserID }
        await store.addLike(Like(id: UUID().uuidString, fromUserID: fromUserID, toUserID: toUserID, createdAt: .now))

        if reverse {
            let match = Match(id: UUID().uuidString, userA: fromUserID, userB: toUserID, createdAt: .now, lastMessagePreview: nil, unreadCount: 0)
            await store.addMatch(match)
            return .matched(match)
        }

        return .pendingLike
    }

    func fetchMatches(for userID: String) async throws -> [Match] {
        await MockStore.shared.allMatches().filter { $0.userA == userID || $0.userB == userID }
    }
}
