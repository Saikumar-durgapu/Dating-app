import Foundation

protocol MatchRepositoryProtocol {
    func discoverCandidates(userID: String) async throws -> [User]
    func like(from userID: String, to targetID: String) async throws -> MatchResult
    func pass(from userID: String, targetID: String) async throws
    func matches(userID: String) async throws -> [Match]
}

struct MatchRepository: MatchRepositoryProtocol {
    let discovery: DiscoveryServiceProtocol
    let matching: MatchServiceProtocol

    func discoverCandidates(userID: String) async throws -> [User] {
        try await discovery.fetchCandidates(for: userID)
    }

    func like(from userID: String, to targetID: String) async throws -> MatchResult {
        try await matching.sendLike(from: userID, to: targetID)
    }

    func pass(from userID: String, targetID: String) async throws {
        try await discovery.pass(on: targetID, by: userID)
    }

    func matches(userID: String) async throws -> [Match] {
        try await matching.fetchMatches(for: userID)
    }
}
