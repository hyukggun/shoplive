//
//  shopliveTests.swift
//  shopliveTests
//
//  Created by hyukmac on 5/25/24.
//

import XCTest
@testable import shoplive

final class shopliveTests: XCTestCase {
    
    let decoder = JSONDecoder()

    func test_public_key() {
        let privateKey = Bundle.main.PUBLIC_KEY
        let expectedKey = "52a6ddab6bfaf0a823a079f74a280c1e"
        XCTAssertTrue(privateKey == expectedKey)
    }
    
    func test_private_key() {
        let publicKey = Bundle.main.PRIVATE_KEY
        let expectedKey = "179a56606259c592b91cb5f096d009e6cf06ec9c"
        XCTAssertTrue(publicKey == expectedKey)
    }
    
    func test_decode_character() {
        let data = """
              {
                "id": 1009351,
                "name": "Hulk",
                "description": "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.",
                "thumbnail": { "path":"http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", "extension":"jpg"}
              }
        """.data(using: .utf8)!
        
        do {
            let hulk = try decoder.decode(MarvelCharacter.self, from: data)
            XCTAssertTrue(hulk.id == 1009351)
            XCTAssertTrue(hulk.name == "Hulk")
            XCTAssertTrue(hulk.description == "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.")
            XCTAssertTrue(hulk.thumbnail.path == "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16")
            XCTAssertTrue(hulk.thumbnail.fileExtension == "jpg")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_decode_character_data_container_empty_reesults() {
        let data = """
         {
            "offset": 0,
            "limit": 20,
            "total": 9,
            "count": 9,
            "results": []
        }
        """.data(using: .utf8)!
        
        do {
            let dataContainer = try decoder.decode(CharacterDataContainer<MarvelCharacter>.self, from: data)
            XCTAssertTrue(dataContainer.offset == 0)
            XCTAssertTrue(dataContainer.limit == 20)
            XCTAssertTrue(dataContainer.total == 9)
            XCTAssertTrue(dataContainer.count == 9)
            XCTAssertTrue(dataContainer.results.isEmpty)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_decode_character_data_container() {
        let data = """
         {
            "offset": 0,
            "limit": 20,
            "total": 9,
            "count": 9,
            "results": [
                      {
                        "id": 1009351,
                        "name": "Hulk",
                        "description": "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.",
                        "thumbnail": { "path":"http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", "extension":"jpg"}
                      }
            ]
        }
        """.data(using: .utf8)!
        
        do {
            let dataContainer = try decoder.decode(CharacterDataContainer<MarvelCharacter>.self, from: data)
            XCTAssertTrue(dataContainer.offset == 0)
            XCTAssertTrue(dataContainer.limit == 20)
            XCTAssertTrue(dataContainer.total == 9)
            XCTAssertTrue(dataContainer.count == 9)
            XCTAssertTrue(!dataContainer.results.isEmpty)
            XCTAssertTrue(dataContainer.results[0].id == 1009351)
            XCTAssertTrue(dataContainer.results[0].name == "Hulk")
            XCTAssertTrue(dataContainer.results[0].description == "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.")
            XCTAssertTrue(dataContainer.results[0].thumbnail.path == "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16")
            XCTAssertTrue(dataContainer.results[0].thumbnail.fileExtension == "jpg")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    
    func test_decode_response() {
        let data = """
        {
        "code": 200,
        "status": "Ok",
        "data": {
            "offset": 0,
            "limit": 20,
            "total": 9,
            "count": 9,
            "results": [
              {
                "id": 1009351,
                "name": "Hulk",
                "description": "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.",
                "thumbnail": { "path":"http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", "extension":"jpg"}
              },
            ]
            }
        }
""".data(using: .utf8)!
        
        do {
            let characterDataWrapper = try decoder.decode(CharacterDataWrapper<MarvelCharacter>.self, from: data)
            XCTAssertTrue(characterDataWrapper.code != nil && characterDataWrapper.code! == 200)
            XCTAssertTrue(characterDataWrapper.status != nil && characterDataWrapper.status! == "Ok")
            XCTAssertNotNil(characterDataWrapper.data)
            XCTAssertTrue(characterDataWrapper.data!.offset == 0)
            XCTAssertTrue(characterDataWrapper.data!.limit == 20)
            XCTAssertTrue(characterDataWrapper.data!.total == 9)
            XCTAssertTrue(characterDataWrapper.data!.count == 9)
            XCTAssertNotNil(characterDataWrapper.data!.results[0])
            XCTAssertTrue(characterDataWrapper.data!.results[0].id == 1009351)
            XCTAssertTrue(characterDataWrapper.data!.results[0].description == "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
