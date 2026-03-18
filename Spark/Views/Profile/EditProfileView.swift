import SwiftUI

struct EditProfileView: View {
    let user: User

    var body: some View {
        Form {
            Text("Edit profile fields")
            NavigationLink("Manage photos", destination: PhotoUploadView())
        }
        .navigationTitle("Edit Profile")
    }
}
