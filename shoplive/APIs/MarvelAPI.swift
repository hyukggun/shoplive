//
//  MarvelAPI.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Moya
import Foundation

enum MarvelAPI: TargetType {
    case fetchCharacters(offset: Int)
    case findCharactersByNameStringWith(namePrefix: String, offset: Int)
    case findCharacters(name: String? = nil, offset: Int)
    
    var publicKey: String {
        Bundle.main.PUBLIC_KEY
    }
    
    var privateKey: String {
        Bundle.main.PRIVATE_KEY
    }
   
    
    var baseURL: URL {
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public") else {
            fatalError("cannot find the URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchCharacters:
            "/characters"
        case .findCharactersByNameStringWith:
            "/characters"
        case .findCharacters:
            "/characters"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchCharacters:
            .get
        case .findCharactersByNameStringWith:
            .get
        case .findCharacters:
            .get
        }
    }
    
    var task: Moya.Task {
        let timestamp = String(Int(Date().timeIntervalSince1970))
        let hash = (timestamp + privateKey + publicKey).md5
        switch self {
        case let .fetchCharacters(offset):
            let params: [String:Any] = [
                "ts": timestamp,
                "apikey": publicKey,
                "hash": hash,
                "limit": 10,
                "offset": offset
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .findCharactersByNameStringWith(namePrefix, offset):
            let params: [String:Any] = [
                "nameStartsWith": namePrefix,
                "ts": timestamp,
                "apikey": publicKey,
                "hash": hash,
                "limit": 10,
                "offset": offset
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case let .findCharacters(name, offset):
            var params: [String:Any] = [
                "ts": timestamp,
                "apikey": publicKey,
                "hash": hash,
                "limit": 10,
                "offset": offset
            ]
            if let name, !name.isEmpty {
                params["nameStartsWith"] = name
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        [:]
    }
}

typealias MarvelAPIProvider = MoyaProvider<MarvelAPI>

func marvelAPIProvider(_ isDebugMode: Bool) -> MarvelAPIProvider {
    if isDebugMode {
        return MarvelAPIProvider(plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))
        ])
    } else {
        return MarvelAPIProvider()
    }
}
