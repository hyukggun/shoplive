//
//  CharacterInfoCellModel.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation

struct CharacterInfoCellModel<ComicsCharacter> where ComicsCharacter: CharacterType {
    var characterInfo: ComicsCharacter
    var isSelected: Bool
    
    init(characterInfo: ComicsCharacter, isSelected: Bool = false) {
        self.characterInfo = characterInfo
        self.isSelected = isSelected
    }
}

typealias MarvelCharacterInfoCellModel = CharacterInfoCellModel<MarvelCharacter>
