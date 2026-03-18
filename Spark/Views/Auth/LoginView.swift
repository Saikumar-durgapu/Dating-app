import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm: AuthViewModel

    init() {
        _vm = StateObject(wrappedValue: AuthViewModel(authService: ServiceContainer.mock.authService))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: SparkSpacing.md) {
                SparkTextField(title: "Email", text: $vm.email)
                SparkTextField(title: "Password", text: $vm.password, isSecure: true)

                SparkButton(title: vm.isLoading ? "Signing in..." : "Login") {
                    Task { await vm.login(appState: appState) }
                }

                NavigationLink("Create account", destination: SignUpView())
                NavigationLink("Forgot password", destination: ForgotPasswordView())

                Divider().padding(.vertical, 8)
                SparkButton(title: "Continue with Apple", style: .secondary) {}
                SparkButton(title: "Continue with Google", style: .secondary) {}

                Spacer()
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}
