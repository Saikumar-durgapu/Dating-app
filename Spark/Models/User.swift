import Foundation

struct User: Codable, Hashable, Identifiable {
    let id: String
    var email: String
    var createdAt: Date
    var profile: UserProfile
}
