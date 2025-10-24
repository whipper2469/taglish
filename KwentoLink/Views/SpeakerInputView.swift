import SwiftUI

struct SpeakerInputView: View {
    @ObservedObject var viewModel: TranslationViewModel
    @State private var activeSpeaker: Speaker?

    var body: some View {
        VStack(spacing: 16) {

            // Display which speaker is active
            if let speaker = activeSpeaker {
                Text("🎙️ Listening to \(speaker.displayName)...")
                    .font(.headline)
                    .foregroundColor(.blue)
            } else {
                Text("Select a speaker to begin recording")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            // Buttons for each speaker
            HStack {
                ForEach(viewModel.sessionSpeakers, id: \.displayName) { speaker in
                    Button(action: {
                        if activeSpeaker == speaker {
                          //  viewModel.stopMicAndCommit()
                            activeSpeaker = nil
                        } else {
                            // viewModel.startMic(for: speaker)

                            activeSpeaker = speaker
                        }
                    }) {
                        Text(speaker.displayName)
                            .padding()
                            .frame(minWidth: 80)
                            .background(activeSpeaker == speaker ? Color.blue : Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    SpeakerInputView(viewModel: TranslationViewModel())
}
