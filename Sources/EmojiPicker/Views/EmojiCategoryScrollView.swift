//
//  EmojiCategoryScrollView.swift
//  EmojiKeyboardDemo
//
//  Created by Mihai Petrenco on 7/3/21.
//

import SwiftUI

struct EmojiCategoryScrollView: View {
    
    /**
     * A key-value pair describing the currently visible categories.
     * It stores the category title as a key and the number of visible emojis as the value.
     *
     * This is done to track when the section title needs to change.
     */
    @State var visibleCategories: [String: Int] = [:]
    
    @Binding var title: String
    @Binding var replacementTitle: String
    
    var onEmojiSelection: ((Emoji) -> Void)?
    var onCategoryChange: ((Int) -> Void)?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                
                Spacer()
                    .frame(width: 16.0)
                
                ForEach(EmojiRepository.shared.categories.indices) { index in
                    
                    EmojiCategoryView(with: EmojiRepository.shared.categories[index],
                                      onVisible: { categoryTitle in
                                        
                                        if (title.isEmpty) {
                                            title = categoryTitle
                                        }
                                        
                                        replacementTitle = categoryTitle
                                        let currentValue = visibleCategories[categoryTitle] ?? 0
                                        visibleCategories.updateValue(currentValue + 1, forKey: categoryTitle)
                                      },
                                      
                                      onHidden: { categoryTitle in
                                        let currentValue = visibleCategories[categoryTitle] ?? 0
                                        visibleCategories.updateValue(currentValue - 1, forKey: categoryTitle)
                                        
                                        if (visibleCategories[categoryTitle] ?? 0 <= 0) {
                                            title = replacementTitle
                                            
                                            let newIndex = EmojiRepository.shared.categories.firstIndex { category in
                                                category.title == title
                                            }
                                            
                                            onCategoryChange?(newIndex ?? 0)
                                        }
                                      },
                    
                                      onEmojiSelection: onEmojiSelection
                    )
                        .id(index)
                }
                
                Spacer()
                    .frame(width: 16.0)
            }
            .animation(.none)
            
        }
    }
}
