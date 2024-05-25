//
//  String+.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import CryptoKit
import Foundation

extension String {
    var md5: String {
        let digest = Insecure.MD5.hash(data: data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
