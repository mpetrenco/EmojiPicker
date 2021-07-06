//
//  EmojiCategoryTitleView.swift
//
//  Created by Mihai Petrenco on 7/3/21.
//

import SwiftUI

private struct Constants {
    static let fontSize: CGFloat = 12.0
    static let leading: CGFloat = 16.0
}

struct EmojiCategoryTitleView: View {
    
    /**
     * The category section title.
     */
    let title: String
    
    /**
     * The main rendering body.
     */
    var body: some View {
        HStack {
            
            Text(title.uppercased())
                .font(.system(size: Constants.fontSize, weight: .semibold))
                .foregroundColor(Color.sectionTitle)
                .padding(.leading, Constants.leading)
            
            Spacer()
        }
    }
}
