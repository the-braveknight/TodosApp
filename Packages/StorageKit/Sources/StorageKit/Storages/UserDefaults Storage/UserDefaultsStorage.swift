//
//  UserDefaultsStorage.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

public struct UserDefaultsStorage: Storage {
    public let defaults: UserDefaults
    
    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    public func set<Key>(_ value: Key.Value, forKey key: Key.Type) throws where Key : StoredKey {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: Key.key)
    }
    
    public func value<Key>(forKey key: Key.Type) throws -> Key.Value? where Key : StoredKey {
        guard let data = defaults.data(forKey: Key.key) else { return nil }
        return try JSONDecoder().decode(Key.Value.self, from: data)
    }
    
    public func removeValue<Key>(forKey key: Key.Type) throws where Key : StoredKey {
        defaults.removeObject(forKey: Key.key)
    }
    
    public func wipeStorage() throws {
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key)
        }
    }
}
