//
//  JJMapper.swift
//  JustJson
//
//  Created by Horst 梁峻浩 on 18/1/2017.
//  Copyright © 2017 VDelegate Limited. All rights reserved.
//

import Foundation

public enum JJMapperError: Error {
    case invalidJSONString
}

public struct JJMapper {
    private let data: [String: Any]
    
    public init(dict: [String: Any]) {
        self.data = dict
    }
    
    public init(jsonStr: String) throws {
        if let _data = jsonStr.toDictionary() {
            self.data = _data
        } else {
            throw JJMapperError.invalidJSONString
        }
    }
    
    subscript(_ path: KeyPath) -> Any? {
        return self.data[keyPath: path]
    }
    
    subscript(string path: KeyPath) -> String? {
        return self.data[string: path]
    }
    
    subscript(dict path: KeyPath) -> [String: Any]? {
        return self.data[dict: path]
    }
    
    subscript(array path: KeyPath) -> [Any]? {
        return self.data[array: path]
    }
    
    subscript(arrayValue path: KeyPath) -> [Any] {
        return self.data[arrayValue: path]
    }
    
    subscript(int path: KeyPath) -> Int? {
        return self.data[int: path]
    }
    
    subscript(intValue path: KeyPath) -> Int {
        return self.data[intValue: path]
    }
    
    subscript(float path: KeyPath) -> Float? {
        return self.data[float: path]
    }
    
    subscript(floatValue path: KeyPath) -> Float {
        return self.data[floatValue: path]
    }
    
    subscript(doubleValue path: KeyPath) -> Double {
        return self.data[doubleValue: path]
    }
    
}

public protocol JJMappable {
    init(map: JJMapper)
}

public extension JJMappable {
    public static func from(_ JSON: [String: Any]) -> Self? {
        return self.init(map: JJMapper(dict: JSON))
    }

    public static func from(_ JSON: [Any]) -> [Self]? {
        if let array = JSON as? [[String: Any]] {
            return array.map { self.init(map: JJMapper(dict: $0)) }
        }
        
        return nil
    }

}

