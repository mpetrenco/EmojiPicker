//
//  EmojiView.swift
//  EmojiKeyboardDemo
//
//  Created by Mihai Petrenco on 7/3/21.
//

import SwiftUI

struct EmojiView: View {
    
    /**
     * The current section title.
     */
    @State var title = ""
    @State var replacementTitle = ""
    @State var currentCategoryIndex = 0
    
    var onEmojiSelection: ((Emoji) -> Void)?
    
    /**
     * Override the initializer to disable the internal scroll view's bounce behavior.
     */
    init(onEmojiSelection: ((Emoji) -> Void)?) {
        self.onEmojiSelection = onEmojiSelection
        UIScrollView.appearance().bounces = false
    }
    
    /**
     * A convenience property for mapping all emoji categories into their respective [EmojiCategoryView] views.
     */
    private var categoryViews = EmojiRepository.shared.categories.map { category in
        EmojiCategoryView(with: category)
    }
    
    var body: some View {
        
        // The ScrollViewReader allows us to use the [proxy] property and programatically
        // scroll to our desired emoji category.
        ScrollViewReader { proxy in
            
            // The section title view section.
            EmojiCategoryTitleView(title: title)
            
            // The main scrollable emoji section
            EmojiCategoryScrollView(title: $title,
                                    replacementTitle: $replacementTitle,
                                    onEmojiSelection: onEmojiSelection) { newCategoryIndex in
                currentCategoryIndex = newCategoryIndex;
            }
            
            // The emoji category picker
            EmojiCategoryPickerView(currentIndex: $currentCategoryIndex) { selectedIndex in
                replacementTitle = EmojiCategoryType.allCases[selectedIndex].rawValue
                title = replacementTitle
                proxy.scrollTo(selectedIndex, anchor: .leading)
            }
        }
        .padding(.bottom, 25.0)
    }
}
