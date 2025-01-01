//
//  Storage.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

/// A protocol that defines a unified interface for persistent storage systems.
///
/// The `Storage` protocol supports type-safe storage operations using `StoredKey` to ensure correctness at compile time.
/// Conforming types (e.g., Keychain, UserDefaults) must implement methods for saving, retrieving, removing, and wiping stored data.
protocol Storage {

    /// Saves a value to the storage system.
    ///
    /// This method encodes the provided value into a format suitable for the storage system.
    ///
    /// - Parameters:
    ///   - value: The value to store, conforming to `Codable`.
    ///   - key: A `StoredKey` that uniquely identifies the value in the storage.
    /// - Throws: An error if the value cannot be encoded or stored.
    func set<Key: StoredKey>(_ value: Key.Value, forKey key: Key.Type) throws

    /// Retrieves a value from the storage system.
    ///
    /// This method decodes the value associated with the provided `StoredKey` from the storage system.
    ///
    /// - Parameter key: A `StoredKey` that uniquely identifies the value in the storage.
    /// - Returns: The value associated with the key, or `nil` if no value exists.
    /// - Throws: An error if the value cannot be retrieved or decoded.
    func value<Key: StoredKey>(forKey key: Key.Type) throws -> Key.Value?

    /// Removes a value from the storage system.
    ///
    /// This method deletes the value associated with the provided `StoredKey` from the storage system.
    ///
    /// - Parameter key: A `StoredKey` that uniquely identifies the value in the storage.
    /// - Throws: An error if the removal operation fails.
    func removeValue<Key: StoredKey>(forKey key: Key.Type) throws

    /// Removes all values from the storage system.
    ///
    /// This method deletes all stored values associated with the storage backend.
    ///
    /// - Throws: An error if the wipe operation fails.
    func wipeStorage() throws
}
