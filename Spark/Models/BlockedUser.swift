import Foundation

struct BlockedUser: Codable, Hashable, Identifiable {
    let id: String
    let userID: String
    let blockedUserID: String
    let createdAt: Date
}
