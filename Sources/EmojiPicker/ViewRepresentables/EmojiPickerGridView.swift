import SwiftUI
import UIKit

struct EmojiPickerGridView: UIViewRepresentable {
    
    // MARK: - Properties
    
    private let emojis: [Emoji]
    private let width: CGFloat
    private let onEmojiAppeared: (Emoji) -> Void
    private let onEmojiSelected: (Emoji) -> Void
        
    // MARK: - Initializers
    
    init(
        with emojis: [Emoji],
        width: CGFloat,
        onEmojiAppeared: @escaping (Emoji) -> Void,
        onEmojiSelected: @escaping (Emoji) -> Void
    ) {
        self.emojis = emojis
        self.width = width
        self.onEmojiAppeared = onEmojiAppeared
        self.onEmojiSelected = onEmojiSelected
    }
    
    // MARK: - UIViewRepresentable
    
    func makeUIView(context: Context) -> UIView {
        let view = EmojiPickerCollectionView(
            with: emojis,
            width: width,
            onEmojiAppeared: onEmojiAppeared,
            onEmojiSelected: onEmojiSelected
        )
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
