//
//  AppStore.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation

enum AppStore {
    private static var SelectedCharactersKey: String {
        "SelectedCharacters"
    }
    
    static func saveSelectedCharacters<ComicsCharacter: Codable & Hashable & CharacterType>(_ characters: [ComicsCharacter]) throws {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(characters)
            UserDefaults.standard.setValue(encodedData, forKey: Self.SelectedCharactersKey)
        } catch {
            throw error
        }
    }
    
    static func fetchSelectedCharacters<ComicsCharacter: Codable & Hashable & CharacterType>() -> [ComicsCharacter] {
        
        if let storedData = UserDefaults.standard.data(forKey: Self.SelectedCharactersKey) {
            do {
                let decoder = JSONDecoder()
                let decodedCharacters = try decoder.decode([ComicsCharacter].self, from: storedData)
                return decodedCharacters
            } catch {
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
        return []
    }
}
