//
//  CharacterDataContainerType.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation

protocol CharacterDataContainerType {
    associatedtype ComicsCharacters: CharacterType
    var offset: Int { get }
    var limit: Int { get }
    var total: Int { get }
    var count: Int { get }
    var results: [ComicsCharacters] { get }
}

struct MarvelCharacterDataContainer: Decodable, CharacterDataContainerType {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [MarvelCharacter]
}
