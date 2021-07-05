//
//  Emoji.swift
//  EmojiKeyboardDemo
//
//  Created by Mihai Petrenco on 7/1/21.
//

import Foundation

public struct Emoji: Codable, Hashable {
    public let emoji: String
    public let category: String
    public let aliases: [String]
    public let tags: [String]
}
