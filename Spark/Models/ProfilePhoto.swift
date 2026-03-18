import Foundation

struct ProfilePhoto: Codable, Hashable, Identifiable {
    let id: String
    let url: URL
    let order: Int
}
