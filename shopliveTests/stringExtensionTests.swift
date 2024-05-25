//
//  stringExtensionTests.swift
//  shopliveTests
//
//  Created by hyukmac on 5/25/24.
//

import XCTest
@testable import shoplive

final class stringExtensionTests: XCTestCase {

    func testMD5() {
        let testString = "Hello, World!"
        let expectedMD5 = "65a8e27d8879283831b664bd8b7f0ad4"
        XCTAssertEqual(testString.md5, expectedMD5, "MD5 hash does not match expected value")
    }
}
