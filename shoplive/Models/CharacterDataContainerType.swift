//
//  CharacterDataContainerType.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation

protocol CharacterDataContainerType {
    associatedtype ComicsCharacter: CharacterType
    var offset: Int { get }
    var limit: Int { get }
    var total: Int { get }
    var count: Int { get }
    var results: [ComicsCharacter] { get }
}

struct CharacterDataContainer: Decodable, CharacterDataContainerType {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [MarvelComicsCharacter]
}
