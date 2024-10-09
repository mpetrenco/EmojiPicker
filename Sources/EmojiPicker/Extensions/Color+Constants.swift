import SwiftUI

extension Color {
    enum EmojiPicker {
        static let background = Color("Background Color", bundle: .module)
        static let contrast = Color("Contrast Color", bundle: .module)
        static let highlight = Color("Highlight Color", bundle: .module)
        static let primary = Color("Primary Color", bundle: .module)
        static let secondary = Color("Secondary Color", bundle: .module)
    }
}

extension UIColor {
    enum EmojiPicker {
        static let background = UIColor(named: "Background Color")
        static let contrast = UIColor(named: "Contrast Color")
        static let highlight = UIColor(named: "Highlight Color")
        static let primary = UIColor(named: "Primary Color")
        static let secondary = UIColor(named: "Secondary Color")
    }
}

extension ShapeStyle {
    typealias EmojiPicker = Color.EmojiPicker
}
