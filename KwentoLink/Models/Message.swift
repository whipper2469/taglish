import Foundation

struct Message: Identifiable, Codable {
    var id: UUID
    var speaker: Speaker
    var originalText: String
    var translatedText: String
    var timestamp: Date

    init(
        id: UUID = UUID(),
        speaker: Speaker,
        originalText: String,
        translatedText: String,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.speaker = speaker
        self.originalText = originalText
        self.translatedText = translatedText
        self.timestamp = timestamp
    }
}
