import Foundation

struct Conversation: Identifiable, Codable {
    var id: UUID
    var title: String
    var speakers: [Speaker]
    var createdAt: Date

    init(id: UUID = UUID(), title: String, speakers: [Speaker], createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.speakers = speakers
        self.createdAt = createdAt
    }
}
