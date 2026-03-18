import Foundation

struct Like: Codable, Hashable, Identifiable {
    let id: String
    let fromUserID: String
    let toUserID: String
    let createdAt: Date
}
