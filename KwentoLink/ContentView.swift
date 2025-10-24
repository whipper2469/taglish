import SwiftUI

struct ContentView: View {
    @StateObject private var translationViewModel = TranslationViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image("TaglishLogo") // replace with your logo asset name if added to Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.top, 40)

                Text("Teglish")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                NavigationLink(destination: LiveTranslationView(viewModel:translationViewModel)) {
                    Text("Start Translating")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("Teglish")
        }
    }
}

#Preview {
    ContentView()
}
