import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Safety Center", destination: SafetyCenterView())
                NavigationLink("Premium", destination: PremiumPlaceholderView())
                Button("Logout") { appState.signOut() }
                Button("Delete account", role: .destructive) {}
            }
            .navigationTitle("Settings")
        }
    }
}
