import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func login(appState: AppState) async {
        await authenticate { try await authService.signIn(email: email, password: password) } appState: appState
    }

    func signUp(appState: AppState) async {
        await authenticate { try await authService.signUp(email: email, password: password) } appState: appState
    }

    private func authenticate(_ op: () async throws -> User, appState: AppState) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let user = try await op()
            appState.signIn(with: user)
        } catch {
            errorMessage = "Authentication failed. Please try again."
        }
    }

    func sendReset() async { try? await authService.forgotPassword(email: email) }
}
