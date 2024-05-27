//
//  SearchCharactersViewState.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation
import OrderedCollections

struct SearchCharactersViewState<ComicsCharacter> where ComicsCharacter: CharacterType & Hashable {
    typealias CellModel = CharacterInfoCellModel<ComicsCharacter>
    
    var characters = OrderedSet<ComicsCharacter>()
    
    var selectedCharacters = OrderedSet<ComicsCharacter>()
    
    private var maxSelectedCharacterCount: Int {
        5
    }
    
    var offset: Int = 0
    
    var total: Int = 0
    
    var isFetchEnabled: Bool {
        if loading { return false }
        if offset == 0 && total == 0 {
            return true
        }
        return offset < total
    }
    
    var loading: Bool = false
    
    var error: Error?
    
    var namePrefix = String() {
        didSet {
            resetCharacters()
        }
    }
    
    var cellModels: [CellModel] {
        var models = [CellModel]()
        for character in characters {
            models.append(CellModel(characterInfo: character, isSelected: selectedCharacters.contains(character)))
        }
        return models
    }
    
    init(_ selectedCharacters: [ComicsCharacter]) {
        self.selectedCharacters.append(contentsOf: selectedCharacters)
    }
    
    mutating func addOrDeleteSelectedCharacter(_ character: ComicsCharacter) {
        if selectedCharacters.contains(character) {
            selectedCharacters.remove(character)
        } else {
            if selectedCharacters.count == maxSelectedCharacterCount {
                selectedCharacters.removeFirst()
            }
            selectedCharacters.append(character)
        }
    }
    
    mutating func updateNamePrefix(_ newNamePrefix: String?) {
        if let newNamePrefix, newNamePrefix != namePrefix {
            namePrefix = newNamePrefix
        }
    }
    
    private mutating func resetCharacters() {
        offset = 0
        total = 0
        characters = []
    }
}
