import Foundation

final class OpenAIService {
    private let apiKey: String
    private let baseURL = URL(string: "https://api.openai.com/v1/chat/completions")!

    init(apiKey: String = "<k-proj-hKb_PZ47QcNyq9ejj-SRZCNvToZiHFgFBxo5AjLA6KNpQaXfqy1ZbLVJ_-v2LQ1lXAiifuchOET3BlbkFJF5igSPUSoBei0xedezYmcw1iHimUUf5BS7otEYuXGuqGBrPlbHBa3we7EaTwxPWve1Ce8lOWMA>") {
        self.apiKey = apiKey
    }

    /// Translates text from one language to another using the GPT model.
    func translateText(text: String, from source: Language, to target: Language) async throws -> String {
        let prompt = """
        Translate the following \(source.displayName) text into \(target.displayName):
        \"\(text)\"
        """

        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "system", "content": "You are a precise translator."],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.3
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "OpenAIService", code: 2, userInfo: [NSLocalizedDescriptionKey: message])
        }

        let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        return decoded.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines) ?? "(No translation)"
    }
}

// MARK: - Response Models

struct OpenAIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: MessageContent
}

struct MessageContent: Codable {
    let role: String
    let content: String
}
