import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        VStack(spacing: SparkSpacing.lg) {
            Spacer()
            Text("Welcome to Spark")
                .font(.largeTitle.bold())
            Text("Connect safely. Match intentionally. Chat instantly.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Spacer()
            SparkButton(title: "Get Started") {
                appState.rootRoute = .auth
            }
        }
        .padding()
    }
}
