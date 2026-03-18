import Foundation

struct MockAuthService: AuthServiceProtocol {
    func signIn(email: String, password: String) async throws -> User {
        if let user = await MockStore.shared.allUsers().first(where: { $0.email.lowercased() == email.lowercased() }) {
            return user
        }
        return try await signUp(email: email, password: password)
    }

    func signUp(email: String, password: String) async throws -> User {
        let user = SampleData.makeNewUser(email: email)
        await MockStore.shared.upsert(user: user)
        return user
    }

    func forgotPassword(email: String) async throws {}

    func signInWithApple() async throws -> User {
        try await signUp(email: "apple_user@spark.app", password: "placeholder")
    }

    func signInWithGoogle() async throws -> User {
        try await signUp(email: "google_user@spark.app", password: "placeholder")
    }
}
