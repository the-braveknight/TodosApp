//
//  KeychainAuthProvider.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Foundation
import Melatonin

actor KeychainAuthManager: AuthManager {
    nonisolated let authService: AuthService
    nonisolated let authStorage: AuthStorage
    
    private var authState: AuthState?
    
    private enum AuthState {
        case complete(Auth)
        case inProgress(Task<Auth, Error>)
    }
    
    init(authService: AuthService, authStorage: AuthStorage) {
        self.authService = authService
        self.authStorage = authStorage
    }
    
    // MARK: - Public Methods
    
    func login(username: String, password: String) async throws {
        let task = Task {
            try await authService.requestAuthorization(email: username, password: password)
        }
        authState = .inProgress(task)
        let auth = try await task.value
        authState = .complete(auth)
        try await authStorage.store(auth)
    }
    
    func logout() async throws {
        authState = nil
        try await authStorage.remove()
    }
    
    func accessToken() async throws -> String {
        let currentAuth = try await currentAuth()
        return currentAuth.accessToken
    }
    
    func refreshAuth() async throws {
        let currentAuth = try await currentAuth()
        
        let refreshTask = Task {
            try await authService.requestAuthorization(refreshToken: currentAuth.refreshToken)
        }
        
        authState = .inProgress(refreshTask)
        let newAuth = try await refreshTask.value
        authState = .complete(newAuth)
        try await authStorage.remove()
    }
    
    // MARK: - Private Methods
    
    private func currentAuth() async throws -> Auth {
        switch authState {
        case .complete(let auth):
            return auth
        case .inProgress(let task):
            return try await task.value
        case nil:
            throw HTTPError(.unauthorized)
        }
    }
}

protocol StoredValueKey {
    static var key: String { get }
    associatedtype Value: Codable
}

extension Keychain {
    func set<Key: StoredValueKey>(_ value: Key.Value, forKey key: Key.Type) throws {
        let data = try JSONEncoder().encode(value)
        try set(data, forKey: Key.key)
    }
    
    func value<Key: StoredValueKey>(forKey key: Key.Type) throws -> Key.Value? {
        guard let data = try data(forKey: Key.key) else { return nil }
        return try JSONDecoder().decode(Key.Value.self, from: data)
    }
    
    func removeValue<Key: StoredValueKey>(forKey key: Key.Type) throws {
        try removeValue(forKey: Key.key)
    }
}

struct AuthKey: StoredValueKey {
    static let key = "authKey"
    typealias Value = Auth
}
