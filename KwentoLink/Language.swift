import Foundation

enum Language: String, Codable {
    case english
    case tagalog

    var displayName: String {
        switch self {
        case .english: return "English"
        case .tagalog: return "Tagalog"
        }
    }

    var speechLocale: Locale {
        switch self {
        case .english: return Locale(identifier: "en-US")
        case .tagalog: return Locale(identifier: "tl-PH")
        }
    }
}
