//
//  Moya+.swift
//  shoplive
//
//  Created by hyukmac on 5/25/24.
//

import Foundation
import Moya

typealias MoyaResponse = Moya.Response
typealias MoyaCancellable = Moya.Cancellable

extension MoyaProvider {
    func request(_ target: Target) async -> Result<MoyaResponse, MoyaError> {
        return await withCheckedContinuation { [weak self] continuation in
            self?.request(target) {
                continuation.resume(returning: $0)
            }
        }
    }
}
