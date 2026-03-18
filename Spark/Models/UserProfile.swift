import Foundation

struct UserProfile: Codable, Hashable {
    var firstName: String
    var dateOfBirth: Date
    var gender: Gender
    var interestedIn: [Gender]
    var bio: String
    var occupation: String
    var heightInCm: Int?
    var interests: [Interest]
    var city: String
    var location: GeoPoint?
    var photos: [ProfilePhoto]
    var hideAge: Bool
    var hideDistance: Bool

    var age: Int {
        Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 18
    }

    var isComplete: Bool {
        !firstName.isEmpty && !bio.isEmpty && !city.isEmpty && !photos.isEmpty && age >= AppConstants.minimumAge
    }
}

enum Gender: String, Codable, CaseIterable, Hashable {
    case woman
    case man
    case nonBinary
    case other
}

struct GeoPoint: Codable, Hashable {
    let latitude: Double
    let longitude: Double
}
