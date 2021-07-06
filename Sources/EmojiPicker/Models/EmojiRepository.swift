//
//  EmojiRepository.swift
//
//  Created by Mihai Petrenco on 7/1/21.
//

import Foundation

struct EmojiRepository {
    
    /**
     * The list of emoji categories to be displayed.
     */
    private (set) var categories: [EmojiCategory] = []
    
    /**
     * The shared instance of the EmojiRepository class.
     */
    static let shared = EmojiRepository()
    
    /**
     * The default initializer, which decodes the emojis from the JSON resource, and sorts them
     * into their respective categories.
     */
    init() {
        do {
            let emojis = try decodeEmojis(at: "emojis")
            categories = sortCategories(for: emojis)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /**
     * A convenience method for decoding the emoji list from the JSON resource.
     *
     * - Parameter resource: the name of the JSON resource containing the emoji list.
     * - Returns: an array of Emoji instances.
     */
    private func decodeEmojis(at resource: String) throws -> [Emoji] {
        let path = Bundle.module.path(forResource: resource, ofType: "json") ?? ""
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try JSONDecoder().decode([Emoji].self, from: data)
    }
    
    /**
     * A convenience method for sorting a list of emojis by their categories.
     *
     * - Parameter emojis: the Emoji instance array to be sorted.
     * - Returns: an array of EmojiCategory instances.
     */
    private func sortCategories(for emojis: [Emoji]) -> [EmojiCategory] {
        var categories: [EmojiCategory] = []
        
        EmojiCategoryType.allCases.forEach { categoryType in
            let categoryEmojis = emojis.filter { $0.category == categoryType.rawValue }
            categories.append(EmojiCategory(title: categoryType.rawValue,
                                            emojis: categoryEmojis))
        }
        return categories
    }
}
