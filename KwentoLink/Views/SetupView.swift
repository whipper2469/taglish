import SwiftUI

struct SetupView: View {
    // Persistent storage
    @AppStorage("speakersList") private var storedSpeakers: String = "You,Ana"
    @AppStorage("taggedSpeaker") private var storedTag: String = ""
    
    @State private var speakers: [String] = []
    @State private var newSpeaker: String = ""
    @State private var selectedTag: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Setup Conversation")
                .font(.largeTitle.bold())
                .padding(.top, 30)

            Text("Manage your participants and tags below.")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // List of current speakers
            List {
                Section(header: Text("Current Participants")) {
                    ForEach(speakers, id: \.self) { speaker in
                        HStack {
                            Text("👤 \(speaker)")
                                .font(.headline)
                            Spacer()
                            if selectedTag == speaker {
                                Text("Tagged")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            } else {
                                Button("Tag") {
                                    selectedTag = speaker
                                    storedTag = speaker
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                    .onDelete(perform: removeSpeaker)
                }
            }
            .listStyle(InsetGroupedListStyle())

            // Add new speaker input
            HStack {
                TextField("Add new speaker...", text: $newSpeaker)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: addSpeaker) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                .disabled(newSpeaker.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding(.horizontal)

            // Show summary info
            VStack {
                Text("Total participants: \(speakers.count)")
                    .font(.headline)
                if let tag = selectedTag {
                    Text("Current tag: \(tag)")
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 10)

            Spacer()

            // Navigation to session
            NavigationLink(destination: LiveTranslationView(viewModel: TranslationViewModel())) {
                Text("Start Conversation")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
        .padding()
        .onAppear(perform: loadSpeakers)
    }

    private func addSpeaker() {
        let trimmed = newSpeaker.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        speakers.append(trimmed)
        newSpeaker = ""
        saveSpeakers()
    }

    private func removeSpeaker(at offsets: IndexSet) {
        speakers.remove(atOffsets: offsets)
        saveSpeakers()
    }

    private func saveSpeakers() {
        storedSpeakers = speakers.joined(separator: ",")
    }

    private func loadSpeakers() {
        speakers = storedSpeakers.split(separator: ",").map { String($0) }
        if !storedTag.isEmpty {
            selectedTag = storedTag
        }
    }
}
