//
//  EmojiCategoryPickerView.swift
//
//  Created by Mihai Petrenco on 7/3/21.
//

import SwiftUI

private struct Constants {
    static let horizontalSpacing: CGFloat = 16.0
    static let categoryItemSize: CGFloat = 24.0
}

struct EmojiCategoryPickerView: View {
    
    /**
     * A binding used to represent the currently selected category index.
     */
    @Binding var currentIndex: Int
    
    /**
     * A callback used to notify that the user has selected a category.
     */
    let onCategorySelection: (Int) -> Void
    
    /**
     * The main rendering body.
     */
    var body: some View {
        HStack(spacing: Constants.horizontalSpacing) {
            ForEach(EmojiCategoryType.allCases.indices, id: \.self) { categoryIndex in
                
                ZStack {
                    
                    if (categoryIndex == currentIndex) {
                        Circle()
                            .foregroundColor(Color.tertiarySurface)
                            .frame(width: Constants.categoryItemSize, height: Constants.categoryItemSize)
                    }
                    
                    Button(
                        action: {
                            currentIndex = categoryIndex
                            onCategorySelection(categoryIndex)
                        },
                        label: {
                            Image(EmojiCategoryType.allCases[categoryIndex].iconName, bundle: .module)
                                .frame(width: Constants.categoryItemSize,
                                       height: Constants.categoryItemSize)
                        })
                }
            }
        }
    }
}
