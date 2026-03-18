import Foundation

protocol AuthServiceProtocol {
    func signIn(email: String, password: String) async throws -> User
    func signUp(email: String, password: String) async throws -> User
    func forgotPassword(email: String) async throws
    func signInWithApple() async throws -> User
    func signInWithGoogle() async throws -> User
}

protocol ProfileServiceProtocol {
    func fetchProfile(for userID: String) async throws -> UserProfile
    func updateProfile(userID: String, profile: UserProfile) async throws -> User
    func uploadPhoto(userID: String, imageData: Data) async throws -> ProfilePhoto
}

protocol DiscoveryServiceProtocol {
    func fetchCandidates(for userID: String) async throws -> [User]
    func pass(on userID: String, by actorID: String) async throws
}

protocol MatchServiceProtocol {
    func sendLike(from fromUserID: String, to toUserID: String) async throws -> MatchResult
    func fetchMatches(for userID: String) async throws -> [Match]
}

protocol ChatServiceProtocol {
    func fetchConversations(for userID: String) async throws -> [Conversation]
    func fetchMessages(conversationID: String) async throws -> [Message]
    func sendMessage(_ content: String, conversationID: String, senderID: String, recipientID: String) async throws -> Message
}

protocol SafetyServiceProtocol {
    func block(userID: String, blockedUserID: String) async throws
    func report(_ report: Report) async throws
    func deleteAccount(userID: String) async throws
}

enum MatchResult {
    case pendingLike
    case matched(Match)
}
