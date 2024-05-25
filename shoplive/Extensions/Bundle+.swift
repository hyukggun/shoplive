//
//  Bundle+.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation

extension Bundle {
    var PRIVATE_KEY: String {
        guard let key = object(forInfoDictionaryKey: "PRIVATE_KEY") as? String else {
            return String()
        }
        return key
    }
    
    var PUBLIC_KEY: String {
        guard let key = object(forInfoDictionaryKey: "PUBLIC_KEY") as? String else {
            return String()
        }
        return key
    }
}
