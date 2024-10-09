import UIKit

final class EmojiPickerCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    private let emojis: [Emoji]
    private let onEmojiAppeared: (Emoji) -> Void
    
    // MARK: - Initializers
    
    init(
        with emojis: [Emoji],
        onEmojiAppeared: @escaping (Emoji) -> Void
    ) {
        self.emojis = emojis
        self.onEmojiAppeared = onEmojiAppeared
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        emojis.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmojiPickerCollectionViewCell.reuseIdentifier,
            for: indexPath
        )
        
        if let emojiCell = cell as? EmojiPickerCollectionViewCell {
            let emoji = emojis[indexPath.row]
            emojiCell.configure(with: emoji)
            onEmojiAppeared(emoji)
        }
        
        return cell
    }
}
