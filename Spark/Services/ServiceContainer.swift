import Foundation

struct ServiceContainer {
    let authService: AuthServiceProtocol
    let profileService: ProfileServiceProtocol
    let discoveryService: DiscoveryServiceProtocol
    let matchService: MatchServiceProtocol
    let chatService: ChatServiceProtocol
    let safetyService: SafetyServiceProtocol

    static let mock = ServiceContainer(
        authService: MockAuthService(),
        profileService: MockProfileService(),
        discoveryService: MockDiscoveryService(),
        matchService: MockMatchService(),
        chatService: MockChatService(),
        safetyService: MockSafetyService()
    )
}
