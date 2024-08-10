import SwiftUI

extension View {
    
    /// Displays an emoji picker overlay.
    ///
    /// - Parameters:
    ///   - isDisplayed: specifies if the picker should be displayed;
    ///   - onEmojiSelected: a callback with the selected `Emoji` value;
    ///
    /// - Returns: a `View` which contains the emoji picker overlay component.
    public func emojiPicker(
        isDisplayed: Binding<Bool>,
        onEmojiSelected: @escaping (Emoji) -> Void
    ) -> some View {
        modifier(
            EmojiPickerModifier(
                isDisplayed: isDisplayed,
                onEmojiSelected: onEmojiSelected
            )
        )
    }
}
