import Foundation

struct MockProfileService: ProfileServiceProtocol {
    func fetchProfile(for userID: String) async throws -> UserProfile {
        guard let user = await MockStore.shared.user(by: userID) else { throw MockError.notFound }
        return user.profile
    }

    func updateProfile(userID: String, profile: UserProfile) async throws -> User {
        guard var user = await MockStore.shared.user(by: userID) else { throw MockError.notFound }
        user.profile = profile
        await MockStore.shared.upsert(user: user)
        return user
    }

    func uploadPhoto(userID: String, imageData: Data) async throws -> ProfilePhoto {
        ProfilePhoto(id: UUID().uuidString, url: URL(string: "https://picsum.photos/400/700")!, order: Int.random(in: 0..<AppConstants.maxProfilePhotos))
    }
}

enum MockError: Error {
    case notFound
}
