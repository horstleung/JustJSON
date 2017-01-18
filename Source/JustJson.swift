//
//  JustJson.swift
//  JustJson
//
//  Created by Horst Leung on 2017-01-16.
//  Copyright © 2017 VDelegate Limited. All rights reserved.
//  Making use of the concept from https://oleb.net/blog/2017/01/dictionary-key-paths/

import Foundation
import UIKit

public struct KeyPath {
    var segments: [String]
    
    var isEmpty: Bool { return segments.isEmpty }
    var path: String {
        return segments.joined(separator: ".")
    }
    
    /// Strips off the first segment and returns a pair
    /// consisting of the first segment and the remaining key path.
    /// Returns nil if the key path has no segments.
    func headAndTail() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail = segments
        let head = tail.removeFirst()
        return (head, KeyPath(segments: tail))
    }
}

public extension KeyPath {
    init(_ string: String) {
        segments = string.components(separatedBy: ".")
    }
}

extension KeyPath: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

public protocol StringProtocol {
    init(string s: String)
}

extension String: StringProtocol {
    public init(string s: String) {
        self = s
    }
}

public extension Dictionary where Key: StringProtocol {
    subscript(keyPath keyPath: KeyPath) -> Any? {
        get {
            switch keyPath.headAndTail() {
            case nil:
                // key path is empty.
                return nil
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                // Reached the end of the key path.
                let key = Key(string: head)
                return self[key]
            case let (head, remainingKeyPath)?:
                // Key path has a tail we need to traverse.
                let key = Key(string: head)
                switch self[key] {
                case let nestedDict as [Key: Any]:
                    // Next nest level is a dictionary.
                    // Start over with remaining key path.
                    return nestedDict[keyPath: remainingKeyPath]
                default:
                    // Next nest level isn't a dictionary.
                    // Invalid key path, abort.
                    return nil
                }
            }
        }

        set {
            switch keyPath.headAndTail() {
            case nil:
                // key path is empty.
                return
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                // Reached the end of the key path.
                let key = Key(string: head)
                self[key] = newValue as? Value
            case let (head, remainingKeyPath)?:
                let key = Key(string: head)
                let value = self[key]
                switch value {
                case var nestedDict as [Key: Any]:
                    // Key path has a tail we need to traverse
                    nestedDict[keyPath: remainingKeyPath] = newValue
                    self[key] = nestedDict as? Value
                default:
                    // Invalid keyPath
                    return
                }
            }
        }
    }
    
    subscript(string keyPath: KeyPath) -> String? {
        get { return self[keyPath: keyPath] as? String }
        set { self[keyPath: keyPath] = newValue }
    }
    
    subscript(stringValue keyPath: KeyPath) -> String {
        get { return self[string: keyPath] ?? "" }
        set { self[keyPath: keyPath] = newValue }
    }
    
    subscript(int keyPath: KeyPath) -> Int? {
        get {
            if let str = self[keyPath: keyPath] as? String {
                return Int(str)
            }
            return self[keyPath: keyPath] as? Int
        }
        set { self[keyPath: keyPath] = newValue }
    }
    
    subscript(intValue keyPath: KeyPath) -> Int {
        get {
            return self[int: keyPath] ?? 0
        }
        set { self[keyPath: keyPath] = newValue }
    }
    
    subscript(float keyPath: KeyPath) -> Float? {
        get {
            if let str = self[keyPath: keyPath] as? String {
                return Float(str)
            }
            
            if let doubleVal = self[keyPath: keyPath] as? Double {
                return Float(doubleVal)
            }
            
            return self[keyPath: keyPath] as? Float
        }
        set { self[keyPath: keyPath] = newValue }
    }
    
    subscript(floatValue keyPath: KeyPath) -> Float {
        get {
            return self[float: keyPath] ?? 0
        }
        set { self[keyPath: keyPath] = newValue }
    }
    
    subscript(double keyPath: KeyPath) -> Double? {
        get {
            if let str = self[keyPath: keyPath] as? String {
                return Double(str)
            }
            return self[keyPath: keyPath] as? Double
        }
        set { self[keyPath: keyPath] = newValue }
    }
    
    subscript(doubleValue keyPath: KeyPath) -> Double {
        get {
            return self[double: keyPath] ?? 0
        }
        set { self[keyPath: keyPath] = newValue }
    }
    
    /**
     Subscript array would return an optional array
     */
    subscript(array keyPath: KeyPath) -> [Any]? {
        get { return self[keyPath: keyPath] as? [Any] }
        set { self[keyPath: keyPath] = newValue }
    }
    
    /**
     Subscript arrayValue would return an array
     */
    subscript(arrayValue keyPath: KeyPath) -> [Any] {
        get { return self[array: keyPath] ?? [Any]() }
        set { self[keyPath: keyPath] = newValue }
    }
    
    subscript(dict keyPath: KeyPath) -> [Key: Any]? {
        get { return self[keyPath: keyPath] as? [Key: Any] }
        set { self[keyPath: keyPath] = newValue }
    }
    
    subscript(dictValue keyPath: KeyPath) -> [Key: Any]? {
        get { return self[dict: keyPath] ?? [Key: Any]() }
        set { self[keyPath: keyPath] = newValue }
    }
   
}

public extension Dictionary where Key: ExpressibleByStringLiteral {
    public func toJSONStr() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

public extension String {
    func toDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}





