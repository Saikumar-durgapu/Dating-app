import Foundation

struct Match: Codable, Hashable, Identifiable {
    let id: String
    let userA: String
    let userB: String
    let createdAt: Date
    var lastMessagePreview: String?
    var unreadCount: Int
}
