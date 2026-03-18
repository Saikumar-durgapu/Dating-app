import SwiftUI

struct ChatView: View {
    let match: Match
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm: ChatViewModel

    init(match: Match) {
        self.match = match
        _vm = StateObject(wrappedValue: ChatViewModel(service: ServiceContainer.mock.chatService))
    }

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(vm.messages) { message in
                        HStack {
                            if message.senderID == (appState.currentUser?.id ?? SampleData.currentUser.id) { Spacer() }
                            Text(message.content)
                                .padding(10)
                                .background(message.senderID == (appState.currentUser?.id ?? SampleData.currentUser.id) ? SparkColor.primary : Color(.secondarySystemBackground))
                                .foregroundStyle(message.senderID == (appState.currentUser?.id ?? SampleData.currentUser.id) ? .white : .primary)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            if message.senderID != (appState.currentUser?.id ?? SampleData.currentUser.id) { Spacer() }
                        }
                    }
                }
                .padding()
            }

            HStack {
                TextField("Type a message", text: $vm.draft)
                    .textFieldStyle(.roundedBorder)
                Button("Send") {
                    Task {
                        let me = appState.currentUser?.id ?? SampleData.currentUser.id
                        let them = match.userA == me ? match.userB : match.userA
                        await vm.send(conversationID: match.id, senderID: me, recipientID: them)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
        .task { await vm.load(conversationID: match.id) }
    }
}
