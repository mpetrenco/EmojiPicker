import UIKit

final class EmojiPickerCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    private let emojis: [Emoji]
    private let onSelectEmoji: (Emoji) -> Void
    
    // MARK: - Initializers
    
    init(
        emojis: [Emoji],
        onSelectEmoji: @escaping (Emoji) -> Void
    ) {
        self.emojis = emojis
        self.onSelectEmoji = onSelectEmoji
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let emoji = emojis[indexPath.row]
        onSelectEmoji(emoji)
    }
}
