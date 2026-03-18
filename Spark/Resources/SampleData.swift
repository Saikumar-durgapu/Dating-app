import Foundation

enum SampleData {
    static let interests = [
        Interest(id: "i1", name: "Travel"),
        Interest(id: "i2", name: "Coffee"),
        Interest(id: "i3", name: "Fitness"),
        Interest(id: "i4", name: "Music")
    ]

    static let currentUser = User(
        id: "u_current",
        email: "me@spark.app",
        createdAt: .now,
        profile: UserProfile(
            firstName: "Alex",
            dateOfBirth: Calendar.current.date(byAdding: .year, value: -27, to: .now) ?? .now,
            gender: .nonBinary,
            interestedIn: [.woman, .man],
            bio: "Builder, runner, and espresso enthusiast.",
            occupation: "Product Designer",
            heightInCm: 173,
            interests: [interests[0], interests[1]],
            city: "San Francisco",
            location: GeoPoint(latitude: 37.7749, longitude: -122.4194),
            photos: [ProfilePhoto(id: "p-me", url: URL(string: "https://picsum.photos/400/700?1")!, order: 0)],
            hideAge: false,
            hideDistance: false
        )
    )

    static let users: [User] = [
        currentUser,
        User(id: "u_1", email: "julia@spark.app", createdAt: .now,
             profile: UserProfile(firstName: "Julia", dateOfBirth: Calendar.current.date(byAdding: .year, value: -25, to: .now)!, gender: .woman, interestedIn: [.man, .nonBinary], bio: "Sushi + sunsets + startup podcasts.", occupation: "Engineer", heightInCm: 168, interests: [interests[0], interests[3]], city: "San Francisco", location: GeoPoint(latitude: 37.78, longitude: -122.42), photos: [ProfilePhoto(id: "p1", url: URL(string: "https://picsum.photos/400/700?2")!, order: 0)], hideAge: false, hideDistance: false)),
        User(id: "u_2", email: "marco@spark.app", createdAt: .now,
             profile: UserProfile(firstName: "Marco", dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: .now)!, gender: .man, interestedIn: [.woman], bio: "Chef on weekends, traveler always.", occupation: "Chef", heightInCm: 180, interests: [interests[1], interests[2]], city: "Oakland", location: GeoPoint(latitude: 37.80, longitude: -122.27), photos: [ProfilePhoto(id: "p2", url: URL(string: "https://picsum.photos/400/700?3")!, order: 0)], hideAge: false, hideDistance: false))
    ]

    static let matches: [Match] = [
        Match(id: "m1", userA: "u_current", userB: "u_1", createdAt: .now, lastMessagePreview: "Hey there 👋", unreadCount: 1)
    ]

    static let conversations: [Conversation] = [
        Conversation(id: "m1", matchID: "m1", participantIDs: ["u_current", "u_1"], lastMessageID: "msg1", updatedAt: .now)
    ]

    static let messages: [Message] = [
        Message(id: "msg1", conversationID: "m1", senderID: "u_1", recipientID: "u_current", content: "Hey there 👋", sentAt: .now, isRead: false, type: .text)
    ]

    static func makeNewUser(email: String) -> User {
        User(
            id: UUID().uuidString,
            email: email,
            createdAt: .now,
            profile: UserProfile(firstName: "", dateOfBirth: Calendar.current.date(byAdding: .year, value: -20, to: .now)!, gender: .other, interestedIn: [], bio: "", occupation: "", heightInCm: nil, interests: [], city: "", location: nil, photos: [], hideAge: false, hideDistance: false)
        )
    }
}
