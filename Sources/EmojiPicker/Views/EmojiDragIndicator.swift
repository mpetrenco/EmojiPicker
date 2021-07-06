//
//  EmojiDragIndicator.swift
//
//  Created by Mihai Petrenco on 7/6/21.
//

import SwiftUI

private struct Constants {
    static let width: CGFloat = 40.0
    static let height: CGFloat = 3.0
    static let cornerRadius: CGFloat = 1.5
}

struct EmojiDragIndicator: View {
    
    /**
     * The main rendering body.
     */
    var body: some View {
        Spacer()
            .frame(width: Constants.width, height: Constants.height)
            .background(Color.secondarySurface)
            .cornerRadius(Constants.cornerRadius)
    }
}
