import Foundation

struct Conversation: Codable, Hashable, Identifiable {
    let id: String
    let matchID: String
    let participantIDs: [String]
    var lastMessageID: String?
    var updatedAt: Date
}
