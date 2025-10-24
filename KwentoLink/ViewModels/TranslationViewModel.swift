import Foundation
import SwiftUI

@MainActor
final class TranslationViewModel: ObservableObject {

    // MARK: - Published UI state
    @Published var messages: [Message] = []
    @Published var sessionSpeakers: [Speaker] = []
    @Published var currentConversation: Conversation? = nil

    @Published var isRecording: Bool = false
    @Published var livePartial: String = ""
    @Published var errorMessage: String? = nil
    @Published var activeSpeaker: Speaker? = nil

    // MARK: - Services
    private let speechService = SpeechService()
    private let openAIService = OpenAIService()

    // MARK: - Start a session (called from SessionSetupView)
    func startSession(speakers: [Speaker]) {
        self.sessionSpeakers = speakers
        self.currentConversation = Conversation(
            title: "Session",
            speakers: speakers
        )
        print("✅ Started session with \(speakers.count) speakers.")
    }

    // MARK: - Start microphone for a specific speaker
    func startMic(for speaker: Speaker) {
        guard !isRecording else { return }
        isRecording = true
        activeSpeaker = speaker
        livePartial = ""

        Task {
            do {
                try await speechService.startStreaming(
                    locale: speaker.primaryLanguage.speechLocale,
                    onPartial: { [weak self] partial in
                        await MainActor.run {
                            self?.livePartial = partial
                        }
                    }
                )
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isRecording = false
                }
            }
        }
    }

    // MARK: - Stop mic and commit current partial as a translated message
    func stopMicAndCommit() {
        guard isRecording else { return }
        speechService.stopStreaming()
        isRecording = false

        guard let speaker = activeSpeaker else { return }
        let original = livePartial.trimmingCharacters(in: .whitespacesAndNewlines)
        livePartial = ""

        // Decide translation direction
        let target: Language = (speaker.primaryLanguage == .english) ? .tagalog : .english

        Task {
            do {
                let translated = try await openAIService.translateText(
                    text: original,
                    from: speaker.primaryLanguage,
                    to: target
                )

                let msg = Message(
                    speaker: speaker,
                    originalText: original,
                    translatedText: translated
                )

                await MainActor.run {
                    self.messages.append(msg)
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
