//
//  JustJsonTests.swift
//  JustJsonTests
//
//  Created by Horst Leung on 2017-01-16.
//  Copyright © 2017 VDelegate Limited. All rights reserved.
//

import XCTest
@testable import JustJson

class JustJsonTests: XCTestCase {
    var dict: [String: Any] = [:]
    var jsonStr: String?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dict = [
            "language": "de",
            "translator": "Erika Fuchs",
            "translations": [
                "characters": [
                    "Scrooge McDuck": "Dagobert",
                    "Huey": "Tick",
                    "Dewey": "Trick",
                    "Louie": "Track",
                    "Gyro Gearloose": "Daniel Düsentrieb",
                ],
                "places": [
                    "Duckburg": "Entenhausen",
                    "Money Bin": "Geldspeicher",
                ]
            ],
            "arrayDict" : [
                "value" : ["1", "2", "3", "5", "7"]
            ]
        ]
        
        jsonStr = dict.toJSONStr()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleGet() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let val = dict[keyPath: "translations.characters.Gyro Gearloose"] as? String
        XCTAssert(val == "Daniel Düsentrieb")
    }
    
    func testSimpleEdit() {
        let editVal = "testing 123"
        dict[keyPath: "translations.characters.Gyro Gearloose"] = editVal
        let val = dict[keyPath: "translations.characters.Gyro Gearloose"] as? String
        XCTAssert(val == editVal)
    }
    
    func testAppendString() {
        let appendVal = " foo foo foo"
        dict[string: "translations.characters.Gyro Gearloose"]?.append(appendVal)
        let val = dict[string: "translations.characters.Gyro Gearloose"]
        XCTAssert(val == "Daniel Düsentrieb".appending(appendVal))
    }
    
    func testAppendNode() {
        dict["hello"] = "world"
        XCTAssert(dict[string: "hello"] == "world")
    }
    
    func testAppendNode2() {
        dict[keyPath: "hello"] = ["testing": ["123" : "yeah"]]
        XCTAssert(dict[string: "hello.testing.123"] == "yeah", dict.toJSONStr() ?? "")
    }
    
    func testRemoveAll() {
        dict[dict: "translations.places"]?.removeAll()
        XCTAssert(dict[dict: "translations.places"]?.count == 0)
    }
    
    func testRemoveNode() {
        dict[keyPath: "translations.places"] = nil
        XCTAssert(dict[keyPath: "translations.places"] == nil)
    }
    
    func testLoopArray() {
        let target = "12357"
        var result = ""
        if let array = dict[array: "arrayDict.value"] {
            for num in array {
                result.append(num as! String)
            }
        }
        XCTAssert(result == target)
    }
    
    func testLoopArray2() {
        let target = "12357"
        var result = ""
        for num in dict[arrayValue: "arrayDict.value"] {
            result.append(num as! String)
        }
        XCTAssert(result == target)
    }
    
    func testPerformanceToJSONStr() {
        self.measure {
            for _ in 0...10000 {
                let _ = self.dict.toJSONStr()
            }
        }
    }
    
    func testPerformanceToDict() {
        self.measure {
            for _ in 0...10000 {
                let _ = self.jsonStr?.toDictionary()
            }
        }
    }
    
}
