import Foundation

struct Message: Codable, Hashable, Identifiable {
    let id: String
    let conversationID: String
    let senderID: String
    let recipientID: String
    let content: String
    let sentAt: Date
    var isRead: Bool
    var type: MessageType
}

enum MessageType: String, Codable, Hashable {
    case text
    case imagePlaceholder
}
