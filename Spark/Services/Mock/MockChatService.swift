import Foundation

struct MockChatService: ChatServiceProtocol {
    func fetchConversations(for userID: String) async throws -> [Conversation] {
        await MockStore.shared.allConversations().filter { $0.participantIDs.contains(userID) }
    }

    func fetchMessages(conversationID: String) async throws -> [Message] {
        await MockStore.shared.allMessages().filter { $0.conversationID == conversationID }.sorted(by: { $0.sentAt < $1.sentAt })
    }

    func sendMessage(_ content: String, conversationID: String, senderID: String, recipientID: String) async throws -> Message {
        let msg = Message(id: UUID().uuidString, conversationID: conversationID, senderID: senderID, recipientID: recipientID, content: content, sentAt: .now, isRead: false, type: .text)
        await MockStore.shared.addMessage(msg)
        return msg
    }
}
