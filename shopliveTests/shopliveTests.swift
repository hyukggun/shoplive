//
//  shopliveTests.swift
//  shopliveTests
//
//  Created by hyukmac on 5/25/24.
//

import XCTest
@testable import shoplive

final class shopliveTests: XCTestCase {

    func test_private_key() {
        let privateKey = Bundle.main.PRIVATE_KEY
        let expectedKey = "52a6ddab6bfaf0a823a079f74a280c1e"
        XCTAssertTrue(privateKey == expectedKey)
    }
    
    func test_public_key() {
        let publicKey = Bundle.main.PUBLIC_KEY
        let expectedKey = "179a56606259c592b91cb5f096d009e6cf06ec9c"
        XCTAssertTrue(publicKey == expectedKey)
    }


}
