import Foundation

protocol UserRepositoryProtocol {
    func currentUserProfile(userID: String) async throws -> UserProfile
    func saveProfile(userID: String, profile: UserProfile) async throws -> User
}

struct UserRepository: UserRepositoryProtocol {
    let profileService: ProfileServiceProtocol

    func currentUserProfile(userID: String) async throws -> UserProfile {
        try await profileService.fetchProfile(for: userID)
    }

    func saveProfile(userID: String, profile: UserProfile) async throws -> User {
        try await profileService.updateProfile(userID: userID, profile: profile)
    }
}
