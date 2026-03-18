import Foundation

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var draft = ""

    private let service: ChatServiceProtocol

    init(service: ChatServiceProtocol) {
        self.service = service
    }

    func load(conversationID: String) async {
        messages = (try? await service.fetchMessages(conversationID: conversationID)) ?? []
    }

    func send(conversationID: String, senderID: String, recipientID: String) async {
        guard !draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let sent = try? await service.sendMessage(draft, conversationID: conversationID, senderID: senderID, recipientID: recipientID)
        draft = ""
        if let sent { messages.append(sent) }
    }
}
