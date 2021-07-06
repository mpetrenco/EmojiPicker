//
//  EmojiCategoryView.swift
//
//  Created by Mihai Petrenco on 7/1/21.
//

import SwiftUI

private struct Constants {
    static let emojiPerRow = 5
    static let horizontalSpacing: CGFloat = 16.0
    static let verticalSpacing: CGFloat = 8.0
    static let emojiSize: CGFloat = 32.0
    static let scrollableAreaHeight: CGFloat = 250.0
}

struct EmojiCategoryView: View {
    
    /**
     * The emoji category to be displayed.
     */
    private let category: EmojiCategory
    
    /**
     * A callback used to notify that a new emoji column has become visible.
     */
    var onVisible: ((String) -> Void)?
    
    /**
     * A callback used to notify that a new emoji column has become hidden.
     */
    var onHidden: ((String) -> Void)?
    
    /**
     * A callback used to notify that an emoji has been selected.
     */
    var onEmojiSelection: ((Emoji) -> Void)?
    
    /**
     * A convenience initializer used to set up the EmojiCategoryView instance.
     *
     * - Parameter category: the emoji category to be displayed.
     * - Parameter onVisible: a callback used to notify that a new emoji column has become visible.
     * - Parameter onHidden: a callback used to notify that a new emoji column has become hidden.
     * - Parameter onEmojiSelection: a convenience initializer used to set up the EmojiCategoryView instance.
     */
    init(with category: EmojiCategory,
         onVisible: ((String) -> Void)? = nil,
         onHidden: ((String) -> Void)? = nil,
         onEmojiSelection: ((Emoji) -> Void)? = nil) {
        
        self.category = category
        self.onVisible = onVisible
        self.onHidden = onHidden
        self.onEmojiSelection = onEmojiSelection
    }
    
    /**
     * The main rendering body.
     */
    var body: some View {
        LazyHStack(alignment: .top, spacing: Constants.horizontalSpacing) {
            
            let rows = category.emojis.split(by: Constants.emojiPerRow)
            
            ForEach(rows, id: \.self) { emojiRow in
                
                LazyVStack(spacing: Constants.verticalSpacing) {
                    
                    ForEach(emojiRow, id: \.self) { emoji in
                        
                        Text(emoji.emoji)
                            .font(.system(size: Constants.emojiSize))
                            .onTapGesture {
                                onEmojiSelection?(emoji)
                            }
                    }
                }
                .onAppear {
                    onVisible?(category.title)
                }
                .onDisappear {
                    onHidden?(category.title)
                }
            }
        }
        .frame(height: Constants.scrollableAreaHeight)
    }
}
