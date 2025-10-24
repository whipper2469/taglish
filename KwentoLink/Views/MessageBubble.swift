import SwiftUI

struct MessageBubble: View {
    let message: Message

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header with speaker info
            HStack {
                // Speaker avatar circle (color fixed to gray since avatarColor no longer exists)
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Text(String(message.speaker.displayName.prefix(1)))
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    )

                // Speaker name
                Text(message.speaker.displayName)
                    .fontWeight(.semibold)

                Spacer()

                // Timestamp
                Text(message.timestamp, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // Original text
            VStack(alignment: .leading, spacing: 4) {
                Text(message.originalText)
                    .font(.body)
            }

            // Translation section
            HStack {
                Image(systemName: "globe")
                    .font(.caption)
                    .foregroundColor(.blue)
                Text(message.translatedText)
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
    }
}
