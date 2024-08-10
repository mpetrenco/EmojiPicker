import Foundation

struct EmojiRepository {
    
    // MARK: - Properties
    
    static let shared = EmojiRepository()
    private(set) var categories: [EmojiCategory] = []
    private(set) var emojis: [Emoji] = []
    
    // MARK: - Initializers
    
    init() {
        do {
            let emojis = try decodeEmojis()
            categories = sortCategories(for: emojis)
            self.emojis = categories.flatMap { $0.emojis }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Helpers
    
    private func decodeEmojis() throws -> [Emoji] {
        let url = Bundle.module.url(
            forResource: "emojis",
            withExtension: "json"
        )
        let data = try Data(contentsOf: url!)
        return try JSONDecoder().decode([Emoji].self, from: data)
    }
    
    private func sortCategories(for emojis: [Emoji]) -> [EmojiCategory] {
        var categories: [EmojiCategory] = []
        
        EmojiCategoryType.allCases.forEach { categoryType in
            let emojis = emojis.filter {
                $0.category == categoryType.title
            }
            
            let category = EmojiCategory(
                title: categoryType.title,
                iconName: categoryType.iconName,
                emojis: emojis
            )
            
            categories.append(category)
        }
        
        return categories
    }
}
