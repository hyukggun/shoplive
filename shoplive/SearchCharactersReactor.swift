//
//  SearchCharactersReactor.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import ReactorKit

class SearchCharactersReactor<ComicsCharacter>: Reactor where ComicsCharacter: Codable & CharacterType & Hashable {
    
    typealias State = SearchCharactersViewState<ComicsCharacter>
    typealias DataWrapper = CharacterDataWrapper<ComicsCharacter>
    
    private let apiProvider = marvelAPIProvider(true)
    
    enum Action {
        case setNamePrefix(nameStartsWith: String)
        case fetchCharacters
        case selectCharacter(ComicsCharacter)
    }
    
    enum Mutation {
        case setLoading(Bool)
        case didSetNamePrefix(nameStartsWith: String)
        case didFetchCharacters(DataWrapper)
        case didSelectCharacter(ComicsCharacter)
        case onError(Error)
        case completed
    }
    
    var initialState: State
    
    private var currentTask: Task<(), Never>?
    
    init() {
        let storedCharacters: [ComicsCharacter] = AppStore.fetchSelectedCharacters()
        initialState = State(storedCharacters)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchCharacters:
            cancelCurrentTask()
            return fetchCharacters(currentState)
        case .setNamePrefix(let namePrefix):
            return .just(.didSetNamePrefix(nameStartsWith: namePrefix))
        case .selectCharacter(let character):
            return .just(.didSelectCharacter(character))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> SearchCharactersViewState<ComicsCharacter> {
        var newState = state
        switch mutation {
        case .didSetNamePrefix(let namePrefix):
            newState.updateNamePrefix(namePrefix)
            cancelCurrentTask()
            asyncOnGlobal(deadline: .milliseconds(300), with: self) {
                $0.action.onNext(.fetchCharacters)
            }
        case .didFetchCharacters(let dataWrapper):
            newState.offset += dataWrapper.data?.limit ?? 0
            newState.total = dataWrapper.data?.total ?? 0
            if let results = dataWrapper.data?.results {
                newState.characters.append(contentsOf: results)
            }
        case .didSelectCharacter(let character):
            newState.addOrDeleteSelectedCharacter(character)
            newState.error = saveSelectedCharacters(newState)
        case .setLoading(let loading):
            newState.loading = loading
        case .onError(let error):
            newState.error = error
        case .completed:
            newState.error = nil
        }
        return newState
    }
    
    private func fetchCharacters(_ state: State) -> Observable<Mutation> {
        if !state.isFetchEnabled { return .never() }
        return .create { [unowned self] observer in
            observer.onNext(.setLoading(true))
            self.currentTask = Task.detached(priority: .background) { [unowned self] in
                let result = await self.apiProvider.request(.findCharacters(name: state.namePrefix, offset: state.offset))
                switch result {
                case .success(let response):
                    do {
                        let dataWrapper = try response.map(DataWrapper.self)
                        observer.onNext(.didFetchCharacters(dataWrapper))
                    } catch {
                        observer.onNext(.onError(error))
                    }
                case .failure(let error):
                    observer.onNext(.onError(error))
                }
                observer.onNext(.completed)
                asyncOnGlobal(deadline: .milliseconds(300)) {
                    observer.onNext(.setLoading(false))
                }
            }
            return Disposables.create { [unowned self] in
                self.currentTask?.cancel()
            }
        }
    }
    
    private func cancelCurrentTask() {
        if let isCancelled = currentTask?.isCancelled, !isCancelled {
            currentTask?.cancel()
        }
        currentTask = nil
    }
    
    private func saveSelectedCharacters(_ state: State) -> Error? {
        let selectedCharacters = Array(state.selectedCharacters)
        do {
            try AppStore.saveSelectedCharacters(selectedCharacters)
            return nil
        } catch {
            return error
        }
    }
}
