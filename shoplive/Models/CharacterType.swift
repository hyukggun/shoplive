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

struct MarvelComicsCharacter: Codable, CharacterType {
    var id: Int
    var name: String
    var description: String
    var thumbnail: CharacterThumbnail
}
