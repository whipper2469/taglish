import Foundation
import Speech
import AVFoundation

final class SpeechService: NSObject, ObservableObject {
    private let audioEngine = AVAudioEngine()
    private let recognizer = SFSpeechRecognizer()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    @Published var isRecording = false

    override init() {
        super.init()
    }

    func startStreaming(locale: Locale, onPartial: @escaping (String) -> Void) async throws {
        // Request speech recognition permission
        try await withCheckedThrowingContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                switch status {
                case .authorized:
                    continuation.resume()
                default:
                    continuation.resume(throwing: NSError(domain: "SpeechService", code: 1, userInfo: [
                        NSLocalizedDescriptionKey: "Speech recognition not authorized"
                    ]))
                }
            }
        }

        // Cancel previous tasks
        recognitionTask?.cancel()
        recognitionTask = nil

        // Create a new recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { return }

        recognitionRequest.shouldReportPartialResults = true

        // Configure the audio engine
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            recognitionRequest.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
        isRecording = true

        // Start recognition task
        recognitionTask = recognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                onPartial(result.bestTranscription.formattedString)
            }

            if error != nil || (result?.isFinal ?? false) {
                self.stop()
            }
        }
    }

    func stop() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        }

        recognitionTask?.cancel()
        recognitionTask = nil
        recognitionRequest = nil
        isRecording = false
    }
}
