//
//  AuthManager.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Foundation
import Melatonin
import StorageKit

actor AuthManager: AuthProvider {
    private let authService: AuthService
    private let authStorage: Storage
    
    private var authState: AuthState?
    
    private enum AuthState {
        case complete(Auth)
        case inProgress(Task<Auth, Error>)
    }
    
    private struct AuthKey: StoredKey {
        static let key = "authKey"
        typealias Value = Auth
    }
    
    init(authService: AuthService, authStorage: Storage) {
        self.authService = authService
        self.authStorage = authStorage
        
        if let storedAuth = try? authStorage.value(forKey: AuthKey.self) {
            self.authState = .complete(storedAuth)
        }
    }
    
    // MARK: - Public Methods
    
    func login(username: String, password: String) async throws {
        let task = Task {
            try await authService.requestAuthorization(email: username, password: password)
        }
        authState = .inProgress(task)
        let auth = try await task.value
        authState = .complete(auth)
        try authStorage.set(auth, forKey: AuthKey.self)
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
        try authStorage.removeValue(forKey: AuthKey.self)
    }
    
    func logout() async throws {
        authState = nil
        try authStorage.removeValue(forKey: AuthKey.self)
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
