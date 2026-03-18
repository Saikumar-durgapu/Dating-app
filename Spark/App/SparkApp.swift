import SwiftUI

@main
struct SparkApp: App {
    @StateObject private var appState = AppState.bootstrap()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}

struct RootView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Group {
            switch appState.rootRoute {
            case .splash:
                SplashView()
            case .onboarding:
                OnboardingView()
            case .auth:
                LoginView()
            case .profileSetup:
                ProfileSetupView()
            case .main:
                MainTabView()
            }
        }
        .preferredColorScheme(appState.settings.preferredColorScheme)
    }
}
