//
//  MarvelAPI.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Moya
import Foundation

enum MarvelAPI: TargetType {
    
    var publicKey: String {
        Bundle.main.PUBLIC_KEY
    }
    
    var privateKey: String {
        Bundle.main.PRIVATE_KEY
    }
    
    case findCharactersByNameStringWith(namePrefix: String)
    
    var baseURL: URL {
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public") else {
            fatalError("cannot find the URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .findCharactersByNameStringWith:
            "/characters"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .findCharactersByNameStringWith:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .findCharactersByNameStringWith(namePrefix):
            let timestamp = String(Int(Date().timeIntervalSince1970))
            let hash = (timestamp + privateKey + publicKey).md5
            let params: [String:Any] = [
                "nameStartsWith": namePrefix,
                "ts": timestamp,
                "apikey": publicKey,
                "hash": hash
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        [:]
    }
}

typealias MarvelAPIProvider = MoyaProvider<MarvelAPI>

func marvelAPIProvider(_ isDebugMode: Bool) -> MarvelAPIProvider {
    MarvelAPIProvider(plugins: [
        NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))
    ])
}
