import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var vm: AuthViewModel
    @State private var sent = false

    init() {
        _vm = StateObject(wrappedValue: AuthViewModel(authService: ServiceContainer.mock.authService))
    }

    var body: some View {
        VStack(spacing: 16) {
            SparkTextField(title: "Email", text: $vm.email)
            SparkButton(title: "Send reset link") {
                Task { await vm.sendReset(); sent = true }
            }
            if sent { Text("Reset instructions sent.").foregroundStyle(.secondary) }
            Spacer()
        }
        .padding()
        .navigationTitle("Forgot password")
    }
}
