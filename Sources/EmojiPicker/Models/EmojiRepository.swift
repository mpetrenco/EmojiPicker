//
//  EmojiRepository.swift
//  EmojiKeyboardDemo
//
//  Created by Mihai Petrenco on 7/1/21.
//

import Foundation

struct EmojiRepository {
    
    private (set) var categories: [EmojiCategory] = []
    
    static let shared = EmojiRepository()
    
    init() {
        do {
            let emojis = try decodeEmojis(at: "emojis")
            categories = sortCategories(for: emojis)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func decodeEmojis(at resource: String) throws -> [Emoji] {
        
        let path = Bundle.module.path(forResource: resource, ofType: "json") ?? ""
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try JSONDecoder().decode([Emoji].self, from: data)
    }
    
    private func sortCategories(for emojis: [Emoji]) -> [EmojiCategory] {
        var categories: [EmojiCategory] = []
        EmojiCategoryType.allCases.forEach { categoryType in
            let categoryEmojis = emojis.filter { $0.category == categoryType.rawValue }
            categories.append(EmojiCategory(title: categoryType.rawValue,
                                            type: categoryType,
                                            emojis: categoryEmojis))
        }
        return categories
    }
    
}
