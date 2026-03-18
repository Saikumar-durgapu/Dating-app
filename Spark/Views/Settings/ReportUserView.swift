import SwiftUI

struct ReportUserView: View {
    @State private var reason = ""

    var body: some View {
        Form {
            TextField("Reason", text: $reason)
            SparkButton(title: "Submit Report", style: .destructive) {}
        }
        .navigationTitle("Report User")
    }
}
