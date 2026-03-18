import Foundation

@MainActor
final class ProfileSetupViewModel: ObservableObject {
    @Published var profile: UserProfile
    @Published var progress: Double = 0

    private let repository: UserRepositoryProtocol

    init(profile: UserProfile, repository: UserRepositoryProtocol) {
        self.profile = profile
        self.repository = repository
        recalculateProgress()
    }

    func recalculateProgress() {
        var total = 9.0
        var complete = 0.0
        if !profile.firstName.isEmpty { complete += 1 }
        if !profile.bio.isEmpty { complete += 1 }
        if !profile.city.isEmpty { complete += 1 }
        if !profile.photos.isEmpty { complete += 1 }
        if !profile.occupation.isEmpty { complete += 1 }
        if !profile.interests.isEmpty { complete += 1 }
        if !profile.interestedIn.isEmpty { complete += 1 }
        if profile.heightInCm != nil { complete += 1 }
        if profile.age >= AppConstants.minimumAge { complete += 1 }
        progress = complete / total
    }

    func save(userID: String) async throws -> User {
        recalculateProgress()
        return try await repository.saveProfile(userID: userID, profile: profile)
    }
}
