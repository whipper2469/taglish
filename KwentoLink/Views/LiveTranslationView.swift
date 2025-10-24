import SwiftUI

import SwiftUI

struct LiveTranslationView: View {
    @ObservedObject var viewModel: TranslationViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Live Translation")
                .font(.headline)

            // Show last translated message
            Text(viewModel.messages.last?.translatedText ?? "—")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(uiColor: .systemGray6))
                .cornerRadius(10)

            // Mic button
            Button(action: {
                if viewModel.isRecording {
                    viewModel.stopMicAndCommit()
                } else if let speaker = viewModel.activeSpeaker {
                    viewModel.start(for: speaker)
                } else {
                    print("⚠️ No active speaker selected.")
                }
            }) {
                Label(
                    viewModel.isRecording ? "Stop Listening" : "Start Listening",
                    systemImage: viewModel.isRecording ? "stop.fill" : "mic.fill"
                )
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isRecording ? Color.red : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .font(.title3.bold())
            }
            .padding(.top, 30)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            Spacer()
        }
        .padding()
        .onDisappear {
           // $viewModel.stopMicAndCommit(){
           //     print ("Testing Code")
          //  }
            }
        }
    }

#Preview {
    LiveTranslationView(viewModel: TranslationViewModel())
}
