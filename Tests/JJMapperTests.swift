//
//  JJMapperTests.swift
//  JustJson
//
//  Created by Horst 梁峻浩 on 18/1/2017.
//  Copyright © 2017 VDelegate Limited. All rights reserved.
//

import Foundation
//
//  JustJsonTests.swift
//  JustJsonTests
//
//  Created by Horst Leung on 2017-01-16.
//  Copyright © 2017 VDelegate Limited. All rights reserved.
//

import XCTest
@testable import JustJson

struct User: JJMappable {
    var id: String
    var name: String
    var age: Int
    
    init(map: JJMapper) {
        id = map[string: "id"]!
        name = map[string: "name"]!
        age = map[intValue: "age"]
    }
}

struct UserGroup: JJMappable {
    var users: [User]?
    
    init(map: JJMapper) {
        users = User.from(map[arrayValue: "users"])
    }
}

class JJMapperTests: XCTestCase {
    var users: [String: Any] = [:]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        users = ["users": [
                [
                    "id" : "1",
                    "name" : "Apple",
                    "age" : 18
                ],
                [
                    "id" : "2",
                    "name" : "Boy",
                    "age" : 19
                ],
                [
                    "id" : "3",
                    "name" : "Cat",
                    "age" : 30
                ],
            ]
        ]
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimple() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let data = users[arrayValue: "users"][1] as! [String: Any]
        let user = User.from(data)
        XCTAssert(user?.age == 19)
    }
    
    func testArray() {
        self.measure {
            let _users = User.from(self.users[arrayValue: "users"])
            XCTAssert(_users?[0].id == "1")
            XCTAssert(_users?[1].id == "2")
            XCTAssert(_users?[2].id == "3")
        }
        
    }
    
    func testNestedMapping() {
        let userGroup = UserGroup.from(self.users)
        XCTAssert(userGroup?.users?[0].id == "1")
        XCTAssert(userGroup?.users?[1].id == "2")
        XCTAssert(userGroup?.users?[2].id == "3")
    }

    
    
}
