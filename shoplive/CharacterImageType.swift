//
//  CharacterImageType.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation

protocol CharacterImageType {
    var path: String { get }
    var fileExtension: String { get }
}

extension CharacterImageType {
    var imageURL: URL? {
        URL(string: path + "." + fileExtension)
    }
}

struct CharacterThumbnailImage: Codable, CharacterImageType {
    var path: String
    var fileExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
