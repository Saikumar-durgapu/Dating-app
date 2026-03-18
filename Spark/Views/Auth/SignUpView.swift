import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm: AuthViewModel
    @State private var acceptedTerms = false

    init() {
        _vm = StateObject(wrappedValue: AuthViewModel(authService: ServiceContainer.mock.authService))
    }

    var body: some View {
        VStack(spacing: SparkSpacing.md) {
            SparkTextField(title: "Email", text: $vm.email)
            SparkTextField(title: "Password", text: $vm.password, isSecure: true)
            Toggle("I accept Terms & Privacy", isOn: $acceptedTerms)
            SparkButton(title: "Sign up") {
                guard acceptedTerms else { return }
                Task { await vm.signUp(appState: appState) }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Create account")
    }
}
