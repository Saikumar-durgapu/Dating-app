import Foundation
import SwiftUI

struct AppSettings: Codable, Hashable {
    var notificationsEnabled: Bool
    var showDistance: Bool
    var showAge: Bool
    var preferredTheme: ThemePreference

    var preferredColorScheme: ColorScheme? {
        switch preferredTheme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    static let defaultSettings = AppSettings(
        notificationsEnabled: true,
        showDistance: true,
        showAge: true,
        preferredTheme: .system
    )
}

enum ThemePreference: String, Codable, Hashable, CaseIterable {
    case system
    case light
    case dark
}
