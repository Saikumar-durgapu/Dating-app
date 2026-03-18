import Foundation

actor MockStore {
    static let shared = MockStore()

    private(set) var users: [User] = SampleData.users
    private(set) var likes: [Like] = []
    private(set) var passes: Set<String> = []
    private(set) var blocks: [BlockedUser] = []
    private(set) var matches: [Match] = SampleData.matches
    private(set) var conversations: [Conversation] = SampleData.conversations
    private(set) var messages: [Message] = SampleData.messages

    func user(by id: String) -> User? { users.first { $0.id == id } }
    func allUsers() -> [User] { users }

    func upsert(user: User) {
        users.removeAll { $0.id == user.id }
        users.append(user)
    }

    func addLike(_ like: Like) { likes.append(like) }
    func allLikes() -> [Like] { likes }

    func addPass(actorID: String, targetID: String) { passes.insert("\(actorID):\(targetID)") }
    func allPasses() -> Set<String> { passes }

    func addBlock(_ block: BlockedUser) { blocks.append(block) }
    func allBlocks() -> [BlockedUser] { blocks }

    func addMatch(_ match: Match) { matches.append(match) }
    func allMatches() -> [Match] { matches }

    func allConversations() -> [Conversation] { conversations }
    func allMessages() -> [Message] { messages }

    func addMessage(_ message: Message) {
        messages.append(message)
    }
}
