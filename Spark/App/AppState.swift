import Foundation
import SwiftUI

enum RootRoute {
    case splash
    case onboarding
    case auth
    case profileSetup
    case main
}

@MainActor
final class AppState: ObservableObject {
    @Published var rootRoute: RootRoute = .splash
    @Published var currentUser: User?
    @Published var settings: AppSettings = .defaultSettings

    let services: ServiceContainer

    init(services: ServiceContainer) {
        self.services = services
    }

    static func bootstrap() -> AppState {
        let container = ServiceContainer.mock
        let state = AppState(services: container)
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            state.rootRoute = .onboarding
        }
        return state
    }

    func signIn(with user: User) {
        currentUser = user
        rootRoute = user.profile.isComplete ? .main : .profileSetup
    }

    func completeProfileAndEnterApp(user: User) {
        currentUser = user
        rootRoute = .main
    }

    func signOut() {
        currentUser = nil
        rootRoute = .auth
    }
}
