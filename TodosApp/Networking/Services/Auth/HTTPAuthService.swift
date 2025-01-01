//
//  HTTPAuthService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Foundation
import Melatonin

actor HTTPAuthService: AuthService, HTTPService {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func requestAuthorization(email: String, password: String) async throws -> Auth {
        let endpoint = Login()
        
        let call = endpoint.call.authorization(.basic(username: email, password: password))
        let (data, _) = try await load(call)
        let decoder = JSONDecoder()
        return try decoder.decode(Auth.self, from: data)
    }
    
    func requestAuthorization(refreshToken: String) async throws -> Auth {
        let endpoint = Refresh()
        
        let call = endpoint.call.authorization(.bearer(token: refreshToken))
        let (data, _) = try await load(call)
        
        let decoder = JSONDecoder()
        return try decoder.decode(Auth.self, from: data)
    }
}
