//
//  KeychainStorage.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

struct KeychainStorage: Storage {
    private let keychain: Keychain
    
    init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    func set<Key>(_ value: Key.Value, forKey key: Key.Type) throws where Key : StoredKey {
        let data = try JSONEncoder().encode(value)
        try keychain.set(data, forKey: key.key)
    }
    
    func value<Key>(forKey key: Key.Type) throws -> Key.Value? where Key : StoredKey {
        guard let data = try keychain.data(forKey: key.key) else { return nil }
        return try JSONDecoder().decode(Key.Value.self, from: data)
    }
    
    func removeValue<Key>(forKey key: Key.Type) throws where Key : StoredKey {
        try keychain.removeValue(forKey: key.key)
    }
    
    func wipeStorage() throws {
        try keychain.wipe()
    }
}
