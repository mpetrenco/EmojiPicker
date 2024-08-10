import Foundation

enum EmojiCategoryType: String, CaseIterable {
    
    // MARK: - Cases
    
    case smileysAndEmotion
    case peopleAndBody
    case animalsAndNature
    case foodAndDrink
    case travelAndPlaces
    case activities
    case objects
    case symbols
    case flags

    // MARK: - Properties
    
    var title: String {
        switch self {
        case .smileysAndEmotion:
            "Smileys & Emotion"
        case .peopleAndBody:
            "People & Body"
        case .animalsAndNature:
            "Animals & Nature"
        case .foodAndDrink:
            "Food & Drink"
        case .travelAndPlaces:
            "Travel & Places"
        case .activities:
            "Activities"
        case .objects:
            "Objects"
        case .symbols:
            "Symbols"
        case .flags:
            "Flags"
        }
    }
    
    var iconName: String {
        switch self {
        case .smileysAndEmotion:
            return "icon.people"
        case .peopleAndBody:
            return "icon.body"
        case .animalsAndNature:
            return "icon.animals"
        case .foodAndDrink:
            return "icon.food"
        case .travelAndPlaces:
            return "icon.travel"
        case .activities:
            return "icon.activity"
        case .objects:
            return "icon.objects"
        case .symbols:
            return "icon.symbols"
        case .flags:
            return "icon.flags"
        }
    }
}
