import Foundation

struct Report: Codable, Hashable, Identifiable {
    let id: String
    let reporterID: String
    let reportedUserID: String
    let reason: String
    let description: String
    let createdAt: Date
}
