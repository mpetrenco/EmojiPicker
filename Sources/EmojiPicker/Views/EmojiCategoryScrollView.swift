//
//  EmojiCategoryScrollView.swift
//
//  Created by Mihai Petrenco on 7/3/21.
//

import SwiftUI

private struct Constants {
    static let horizontalPadding: CGFloat = 16.0
}

struct EmojiCategoryScrollView: View {
    
    /**
     * A key-value pair describing the currently visible categories.
     * It stores the category title as a key and the number of visible emojis as the value.
     *
     * This is done to track when the section title needs to change.
     */
    @State var visibleCategories: [String: Int] = [:]
    
    /**
     * A binding used to track the current section title.
     */
    @Binding var title: String
    
    /**
     * A binding used to track the next section title, that will replace the current title once
     * no more emojis from the previous category are visible.
     */
    @Binding var replacementTitle: String
    
    /**
     * A callback used to notify that an emoji has been selected.
     */
    var onEmojiSelection: ((Emoji) -> Void)?
    
    /**
     * A callback used to notify that the category has changed.
     */
    var onCategoryChange: ((Int) -> Void)?
    
    /**
     * The main rendering body.
     */
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                
                Spacer()
                    .frame(width: Constants.horizontalPadding)
                
                ForEach(EmojiRepository.shared.categories.indices) { index in
                    
                    EmojiCategoryView(with: EmojiRepository.shared.categories[index],
                                      onVisible: onCategoryVisible,
                                      onHidden: onCategoryHidden,
                                      onEmojiSelection: onEmojiSelection)
                        .id(index)
                }
                
                Spacer()
                    .frame(width: Constants.horizontalPadding)
            }
            .animation(.none)
            
        }
    }
    
    /**
     * A convenience method which keeps track of newly visible emojis and
     * adds them to the `visibleCategories` dictionary.
     */
    private func onCategoryVisible(with categoryTitle: String) {
        if (title.isEmpty) {
            title = categoryTitle
        }
        
        replacementTitle = categoryTitle
        let currentValue = visibleCategories[categoryTitle] ?? 0
        visibleCategories.updateValue(currentValue + 1, forKey: categoryTitle)
    }
    
    /**
     * A convenience method which keeps track of newly hidden emojis, removes them
     * from the `visibleCategories` dictionary, and updates the section title once
     * all emojis from that category are hidden.
     */
    private func onCategoryHidden(with categoryTitle: String) {
        let currentValue = visibleCategories[categoryTitle] ?? 0
        visibleCategories.updateValue(currentValue - 1, forKey: categoryTitle)
        
        if (visibleCategories[categoryTitle] ?? 0 <= 0) {
            title = replacementTitle
            
            let newIndex = EmojiRepository.shared.categories.firstIndex { category in
                category.title == title
            }
            
            onCategoryChange?(newIndex ?? 0)
        }
    }
}
