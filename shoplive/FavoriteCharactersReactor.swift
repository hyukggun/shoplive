//
//  FavoriteCharactersReactor.swift
//  shoplive
//
//  Created by hyukmac on 5/26/24.
//

import Foundation
import ReactorKit

class FavoriteCharactersReactor<ComicsCharacter>: Reactor where ComicsCharacter: Decodable & CharacterType & Hashable {
    
    enum Action {
        case setFavoriteCharacters([ComicsCharacter])
        case selectCharacter(ComicsCharacter)
    }
    
    enum Mutation {
        case didSetFavoriteCharacters([ComicsCharacter])
        case didSelectCharacter(ComicsCharacter)
    }
    
    struct State {
        fileprivate var favoriteCharacters: [ComicsCharacter] = []
        var cellModels: [CharacterInfoCellModel<ComicsCharacter>] {
            favoriteCharacters.map { CharacterInfoCellModel(characterInfo: $0) }
        }
        var selectedCharacter: ComicsCharacter?
        var isFavoriteCharactersEmpty: Bool { favoriteCharacters.isEmpty }
    }
    
    var initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setFavoriteCharacters(let characters):
            return .just(.didSetFavoriteCharacters(characters))
        case .selectCharacter(let character):
            return .just(.didSelectCharacter(character))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .didSetFavoriteCharacters(let characters):
            newState.favoriteCharacters = characters
        case .didSelectCharacter(let character):
            newState.selectedCharacter = character
        }
        return newState
    }
}

typealias FavoriteMarvelCharactersReactor = FavoriteCharactersReactor<MarvelCharacter>
