//
//  KeychainStorage.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

public struct KeychainStorage: Storage, Sendable {
    private let keychain: Keychain
    
    public init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    public func set<Key>(_ value: Key.Value, forKey key: Key.Type) throws where Key : StoredKey {
        let data = try JSONEncoder().encode(value)
        try keychain.set(data, forKey: key.key)
    }
    
    public func value<Key>(forKey key: Key.Type) throws -> Key.Value? where Key : StoredKey {
        guard let data = try keychain.data(forKey: key.key) else { return nil }
        return try JSONDecoder().decode(Key.Value.self, from: data)
    }
    
    public func removeValue<Key>(forKey key: Key.Type) throws where Key : StoredKey {
        try keychain.removeValue(forKey: key.key)
    }
    
    public func wipeStorage() throws {
        try keychain.wipe()
    }
}
