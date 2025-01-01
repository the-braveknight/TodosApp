//
//  DefaultsStorage.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

struct UserDefaultsStorage: Storage {
    let defaults: UserDefaults
    
    func set<Key>(_ value: Key.Value, forKey key: Key.Type) throws where Key : StoredKey {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: Key.key)
    }
    
    func value<Key>(forKey key: Key.Type) throws -> Key.Value? where Key : StoredKey {
        guard let data = defaults.data(forKey: Key.key) else { return nil }
        return try JSONDecoder().decode(Key.Value.self, from: data)
    }
    
    func removeValue<Key>(forKey key: Key.Type) throws where Key : StoredKey {
        defaults.removeObject(forKey: Key.key)
    }
    
    func wipeStorage() throws {
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key)
        }
    }
}
