import Foundation

struct Speaker: Identifiable, Codable, Equatable {
    let id: UUID
    let displayName: String
    let primaryLanguage: Language

    init(id: UUID = UUID(), displayName: String, primaryLanguage: Language) {
        self.id = id
        self.displayName = displayName
        self.primaryLanguage = primaryLanguage
    }
}
