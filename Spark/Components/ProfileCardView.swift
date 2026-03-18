import SwiftUI

struct ProfileCardView: View {
    let user: User

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: user.profile.photos.first?.url) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                LinearGradient.sparkPrimary
            }
            .frame(height: 520)
            .clipped()

            LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .center, endPoint: .bottom)

            VStack(alignment: .leading, spacing: 6) {
                Text("\(user.profile.firstName), \(user.profile.age)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Text(user.profile.city)
                    .foregroundStyle(.white.opacity(0.9))
                Text(user.profile.interests.prefix(3).map(\.name).joined(separator: " • "))
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.85))
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 6)
    }
}
