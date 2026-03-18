import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradient.sparkPrimary.ignoresSafeArea()
            VStack(spacing: 10) {
                Text("Spark")
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text("Find your person")
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
    }
}
