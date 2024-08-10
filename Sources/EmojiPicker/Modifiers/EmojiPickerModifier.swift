import SwiftUI

struct EmojiPickerModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding private var isDisplayed: Bool
    private let onEmojiSelected: (Emoji) -> Void
    
    // MARK: - Initializers
    
    init(
        isDisplayed: Binding<Bool>,
        onEmojiSelected: @escaping (Emoji) -> Void
    ) {
        _isDisplayed = isDisplayed
        self.onEmojiSelected = onEmojiSelected
    }
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        content.overlay {
            EmojiPickerView(
                isDisplayed: $isDisplayed,
                onEmojiSelected: onEmojiSelected
            )
        }
    }
}

