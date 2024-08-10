import Foundation

struct EmojiCategory: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    let emojis: [Emoji]
}
