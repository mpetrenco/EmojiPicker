//
//  Emoji.swift
//
//  Created by Mihai Petrenco on 7/1/21.
//

import Foundation

public struct Emoji: Codable, Hashable {
    
    /**
     * The emoji string value.
     */
    public let emoji: String
    
    /**
     * The category name of the emoji.
     */
    public let category: String
    
    /**
     * A list of aliases for the current emoji.
     */
    public let aliases: [String]
    
    /**
     * A list of tags used to identify the emoji.
     */
    public let tags: [String]
}
