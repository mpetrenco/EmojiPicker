//
//  EmojiCategoryTitleView.swift
//  EmojiKeyboardDemo
//
//  Created by Mihai Petrenco on 7/3/21.
//

import SwiftUI

struct EmojiCategoryTitleView: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title.uppercased())
                .font(.system(size: 12.0, weight: .semibold))
                .foregroundColor(Color.sectionTitle)
                .padding(.leading, 16.0)
            Spacer()
        }
    }
}
