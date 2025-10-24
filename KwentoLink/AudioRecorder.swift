import Foundation
import AVFoundation

final class AudioRecorder: NSObject, ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var audioFileURL: URL?

    @Published var isRecording = false
    @Published var isPlaying = false

    // MARK: - Start Recording
    func startRecording(to fileURL: URL) throws {
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
        audioRecorder?.record()
        audioFileURL = fileURL
        isRecording = true
    }

    // MARK: - Stop Recording
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
    }

    // MARK: - Playback
    func playRecording() {
        guard let url = audioFileURL else {
            print("No recording found to play.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Playback error: \(error)")
        }
    }

    // MARK: - Stop Playback
    func stopPlayback() {
        audioPlayer?.stop()
        isPlaying = false
    }
}
