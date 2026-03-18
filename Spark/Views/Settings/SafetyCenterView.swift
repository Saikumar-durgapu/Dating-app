import SwiftUI

struct SafetyCenterView: View {
    var body: some View {
        List {
            NavigationLink("Report user", destination: ReportUserView())
            Text("Block user flow is available from profile and chat options.")
            Text("Safety tip: Meet in public spaces and tell a friend your plans.")
        }
        .navigationTitle("Safety Center")
    }
}
