//
//  CharacterDataWrapperType.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation

protocol CharacterDataWrapperType {
    associatedtype ComicsCharacterDataContainer: CharacterDataContainerType
    var code: Int? { get }
    var status: String? { get }
    var data: ComicsCharacterDataContainer? { get }
}

struct CharacterDataWrapper<ComicsCharacter>: Decodable, CharacterDataWrapperType where ComicsCharacter: Decodable & Hashable & CharacterType {
    var code: Int?
    var status: String?
    var data: CharacterDataContainer<ComicsCharacter>?
}
