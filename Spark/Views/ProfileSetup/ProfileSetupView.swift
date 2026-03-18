import SwiftUI

struct ProfileSetupView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm: ProfileSetupViewModel

    init() {
        let user = SampleData.currentUser
        _vm = StateObject(wrappedValue: ProfileSetupViewModel(
            profile: user.profile,
            repository: UserRepository(profileService: ServiceContainer.mock.profileService)
        ))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Basics") {
                    TextField("First name", text: $vm.profile.firstName)
                    DatePicker("Date of birth", selection: $vm.profile.dateOfBirth, displayedComponents: .date)
                    TextField("City", text: $vm.profile.city)
                    TextField("Occupation", text: $vm.profile.occupation)
                    TextField("Bio", text: $vm.profile.bio, axis: .vertical)
                }

                Section("Progress") {
                    ProgressView(value: vm.progress)
                    Text("\(Int(vm.progress * 100))% complete")
                }
            }
            .navigationTitle("Create Profile")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            let id = appState.currentUser?.id ?? SampleData.currentUser.id
                            if let user = try? await vm.save(userID: id) {
                                appState.completeProfileAndEnterApp(user: user)
                            }
                        }
                    }
                }
            }
        }
    }
}
