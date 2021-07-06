//
//  EmojiView.swift
//
//  Created by Mihai Petrenco on 7/3/21.
//

import SwiftUI

private struct Constants {
    static let bottomPadding: CGFloat = 25.0
}

struct EmojiView: View {
    
    /**
     * The current section title.
     */
    @State var title = ""
    
    /**
     * The title to replace the current section title, once no emojis from the previous categories are visible.
     */
    @State var replacementTitle = ""
    
    /**
     * The current emoji category index.
     */
    @State var currentCategoryIndex = 0
    
    /**
     * A callback used to notify that an emoji has been selected.
     */
    var onEmojiSelection: ((Emoji) -> Void)?
    
    /**
     * Overrides the default initializer to disable the internal scroll view's bounce behavior.
     *
     * - Parameter onEmojiSelection - a callback used to notify that an emoji has been selected.
     */
    init(onEmojiSelection: ((Emoji) -> Void)?) {
        self.onEmojiSelection = onEmojiSelection
        UIScrollView.appearance().bounces = false
    }
    
    /**
     * The main rendering body.
     */
    var body: some View {
        
        ScrollViewReader { proxy in
            
            EmojiCategoryTitleView(title: title)
            
            EmojiCategoryScrollView(title: $title,
                                    replacementTitle: $replacementTitle,
                                    onEmojiSelection: onEmojiSelection) { newCategoryIndex in
                currentCategoryIndex = newCategoryIndex;
            }
            
            EmojiCategoryPickerView(currentIndex: $currentCategoryIndex) { selectedIndex in
                replacementTitle = EmojiCategoryType.allCases[selectedIndex].rawValue
                title = replacementTitle
                proxy.scrollTo(selectedIndex, anchor: .leading)
            }
        }
        .padding(.bottom, Constants.bottomPadding)
    }
    
    /**
     * A convenience property for mapping all emoji categories into their respective [EmojiCategoryView] views.
     */
    private var categoryViews = EmojiRepository.shared.categories.map { category in
        EmojiCategoryView(with: category)
    }
}
