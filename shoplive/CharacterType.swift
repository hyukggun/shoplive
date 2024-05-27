//
//  CharacterType.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation

protocol CharacterType {
    associatedtype Thumbnail: CharacterImageType
    var id: Int { get }
    var name: String { get }
    var description: String { get }
    var thumbnail: Thumbnail { get }
}

struct MarvelCharacter: Codable, Hashable, CharacterType {
    var id: Int
    var name: String
    var description: String
    var thumbnail: CharacterThumbnailImage
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
