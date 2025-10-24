import SwiftUI

struct SessionSetupView: View {
    @ObservedObject var viewModel: TranslationViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Configure your translation session")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button("Start Session") {
                let testSpeakers = [
                    Speaker(displayName: "You", primaryLanguage: .english),
                    Speaker(displayName: "Ana", primaryLanguage: .tagalog)
                ]

                // ✅ Call method directly on ObservedObject
                viewModel.startSession(Speakers: testSpeakers)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    //SessionSetupView(viewModel: TranslationViewModel(openAIService: //OpenAIService()))
    
}
