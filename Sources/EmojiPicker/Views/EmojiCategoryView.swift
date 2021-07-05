//
//  EmojiCategoryView.swift
//  EmojiKeyboardDemo
//
//  Created by Mihai Petrenco on 7/1/21.
//

import SwiftUI

private struct Constants {
    static let emojiPerRow = 5
    static let horizontalSpacing: CGFloat = 16.0
    static let verticalSpacing: CGFloat = 8.0
    static let emojiSize: CGFloat = 32.0
}

struct EmojiCategoryView: View {
    
    private let category: EmojiCategory
    var onVisible: ((String) -> Void)?
    var onHidden: ((String) -> Void)?
    var onEmojiSelection: ((Emoji) -> Void)?
    
    init(with category: EmojiCategory,
         onVisible: ((String) -> Void)? = nil,
         onHidden: ((String) -> Void)? = nil,
         onEmojiSelection: ((Emoji) -> Void)? = nil) {
        
        self.category = category
        self.onVisible = onVisible
        self.onHidden = onHidden
        self.onEmojiSelection = onEmojiSelection
    }
    
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
        .frame(height: 250)
    }
}
