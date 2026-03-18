import SwiftUI

enum SparkColor {
    static let primary = Color(red: 0.97, green: 0.21, blue: 0.43)
    static let secondary = Color(red: 0.55, green: 0.23, blue: 0.96)
    static let bg = Color(.systemBackground)
    static let card = Color(.secondarySystemBackground)
    static let success = Color.green
    static let danger = Color.red
}

enum SparkSpacing {
    static let xs: CGFloat = 6
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}

extension LinearGradient {
    static let sparkPrimary = LinearGradient(
        colors: [SparkColor.primary, SparkColor.secondary],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
