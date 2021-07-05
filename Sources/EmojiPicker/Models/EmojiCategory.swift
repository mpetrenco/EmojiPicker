//
//  EmojiCategory.swift
//  EmojiKeyboardDemo
//
//  Created by Mihai Petrenco on 7/1/21.
//

import Foundation

enum EmojiCategoryType: String, CaseIterable {
    case smileysAndEmotion = "Smileys & Emotion"
    case peopleAndBody = "People & Body"
    case animalsAndNature = "Animals & Nature"
    case foodAndDrink = "Food & Drink"
    case travelAndPlaces = "Travel & Places"
    case activities = "Activities"
    case objects = "Objects"
    case symbols = "Symbols"
    case flags = "Flags"
    
    var iconName: String {
        switch self {
        case .smileysAndEmotion:
            return "emojis_emoticons"
        case .peopleAndBody:
            return "emojis_body"
        case .animalsAndNature:
            return "emojis_animals"
        case .foodAndDrink:
            return "emojis_food"
        case .travelAndPlaces:
            return "emojis_travel"
        case .activities:
            return "emojis_activity"
        case .objects:
            return "emojis_object"
        case .symbols:
            return "emojis_symbols"
        case .flags:
            return "emojis_flags"
        }
    }
}

struct EmojiCategory: Hashable {
    let title: String
    let type: EmojiCategoryType
    let emojis: [Emoji]
}
