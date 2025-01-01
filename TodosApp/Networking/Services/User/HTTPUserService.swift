//
//  HTTPUserService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/31/24.
//

import Foundation

actor HTTPUserService: UserService, AuthorizedHTTPService {
    let session: URLSession
    let authProvider: AuthProvider
    
    init(session: URLSession, authProvider: AuthProvider) {
        self.session = session
        self.authProvider = authProvider
    }
    
    func fetchUser() async throws -> User {
        let endpoint = GetUser()
        let call = endpoint.call
        let (data, _) = try await loadWithAuth(call)
        let decoder = JSONDecoder()
        return try decoder.decode(User.self, from: data)
    }
}
