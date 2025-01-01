//
//  InMemoryStorage.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

class InMemoryStorage: Storage {
    private var dictionary: [String: Data] = [:]
    
    func set<Key>(_ value: Key.Value, forKey key: Key.Type) throws where Key : StoredKey {
        let data = try JSONEncoder().encode(value)
        dictionary[Key.key] = data
    }
    
    func value<Key>(forKey key: Key.Type) throws -> Key.Value? where Key : StoredKey {
        guard let data = dictionary[Key.key] else { return nil }
        return try JSONDecoder().decode(Key.Value.self, from: data)
    }
    
    func removeValue<Key>(forKey key: Key.Type) throws where Key : StoredKey {
        dictionary.removeValue(forKey: Key.key)
    }
    
    func wipeStorage() throws {
        dictionary.removeAll()
    }
}

extension Storage where Self == InMemoryStorage {
    static var inMemory: Self { Self() }
}
