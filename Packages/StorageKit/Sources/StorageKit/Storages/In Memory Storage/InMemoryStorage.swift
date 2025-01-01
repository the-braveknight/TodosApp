//
//  InMemoryStorage.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

final public class InMemoryStorage: Storage, @unchecked Sendable {
    private var dictionary: [String: Data] = [:]
    
    public func set<Key>(_ value: Key.Value, forKey key: Key.Type) throws where Key : StoredKey {
        let data = try JSONEncoder().encode(value)
        dictionary[Key.key] = data
    }
    
    public func value<Key>(forKey key: Key.Type) throws -> Key.Value? where Key : StoredKey {
        guard let data = dictionary[Key.key] else { return nil }
        return try JSONDecoder().decode(Key.Value.self, from: data)
    }
    
    public func removeValue<Key>(forKey key: Key.Type) throws where Key : StoredKey {
        dictionary.removeValue(forKey: Key.key)
    }
    
    public func wipeStorage() throws {
        dictionary.removeAll()
    }
}

public extension Storage where Self == InMemoryStorage {
    static var inMemory: Self { Self() }
}
