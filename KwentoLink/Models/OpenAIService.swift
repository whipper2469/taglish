import Foundation

@MainActor
import Foundation

final class OpenAIService {
    private let apiKey = "<k-proj-hKb_PZ47QcNyq9ejj-SRZCNvToZiHFgFBxo5AjLA6KNpQaXfqy1ZbLVJ_-v2LQ1lXAiifuchOET3BlbkFJF5igSPUSoBei0xedezYmcw1iHimUUf5BS7otEYuXGuqGBrPlbHBa3we7EaTwxPWve1Ce8lOWMA>" // Replace with your actual key

    // Existing translateText function
    func translateText(text: String, from source: Language, to target: Language) async throws -> String {
        // Simulated translation for now
        // Replace this with your real API call if needed
        return "[\(target.rawValue) translation of \(text)]"
    }

    // ✅ Add this missing function
    func quickReplies(context: String, targetLanguage: Language) async throws -> [String] {
        // Simulated response for now, replace with your actual API integration later
        let replies = [
            "Can you explain more?",
            "That's interesting!",
            "How do you feel about that?",
            "Tell me more about it.",
            "I agree with you.",
            "Why do you think so?",
            "Could you repeat that?",
            "That's cool!"
        ]

        // Pretend we translated them into the target language
        return replies.map { "\(targetLanguage.rawValue): \($0)" }
    }
}
    // ✅ Add this missing function
    func quickReplies(context: String, targetLanguage: Language) async throws -> [String] {
        // Simulated response for now, replace with your actual API integration later
        let replies = [
            "Can you explain more?",
            "That's interesting!",
            "How do you feel about that?",
            "Tell me more about it.",
            "I agree with you.",
            "Why do you think so?",
            "Could you repeat that?",
            "That's cool!"
        ]

        // Pretend we translated them into the target language
        return replies.map { "\(targetLanguage.rawValue): \($0)" }
    }
}
