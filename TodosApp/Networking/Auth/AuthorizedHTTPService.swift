//
//  AuthorizedHTTPService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Foundation
import Melatonin

protocol AuthorizedHTTPService: HTTPService {
    var authProvider: AuthProvider { get }
    func loadWithAuth<Call : HTTPCall>(_ call: Call) async throws -> (Data, HTTPURLResponse)
}

extension AuthorizedHTTPService {
    func loadWithAuth<Call : HTTPCall>(_ call: Call) async throws -> (Data, HTTPURLResponse) {
        let accessToken = try await authProvider.accessToken()
        let initialCall = call.authorization(.bearer(token: accessToken))
        let (data, response) = try await load(initialCall)
        
        if response.statusCode == 401 {
            try await authProvider.refreshAuth()
            let accessToken = try await authProvider.accessToken()
            let refreshedCall = call.authorization(.bearer(token: accessToken))
            let (data, response) = try await load(refreshedCall)
            
            if response.statusCode == 401 {
                throw HTTPError(.unauthorized)
            }
            
            return (data, response)
        }
        
        return (data, response)
    }
}
