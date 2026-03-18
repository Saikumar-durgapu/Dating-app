import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appState: AppState

    var user: User {
        appState.currentUser ?? SampleData.currentUser
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ProfileCardView(user: user)
                    Text(user.profile.bio).frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink("Edit Profile", destination: EditProfileView(user: user))
                    NavigationLink("Preview Public Profile", destination: ProfileCardView(user: user).padding())
                }
                .padding()
            }
            .navigationTitle("My Profile")
        }
    }
}
