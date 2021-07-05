//
//  EmojiCategoryPickerView.swift
//  EmojiKeyboardDemo
//
//  Created by Mihai Petrenco on 7/3/21.
//

import SwiftUI

private struct Constants {
    static let horizontalSpacing: CGFloat = 16.0
    static let categoryItemSize: CGFloat = 24.0
}

struct EmojiCategoryPickerView: View {
    
    @Binding var currentIndex: Int
    
    let onCategorySelection: (Int) -> Void
    
    var body: some View {
        HStack(spacing: Constants.horizontalSpacing) {
            ForEach(EmojiCategoryType.allCases.indices, id: \.self) { categoryIndex in
                
                ZStack {
                    
                    if (categoryIndex == currentIndex) {
                        Circle()
                            .foregroundColor(Color.tertiarySurface)
                            .frame(width: 24.0, height: 24.0)
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
