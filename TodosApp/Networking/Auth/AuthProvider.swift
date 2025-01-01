//
//  AuthProvider.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/31/24.
//

protocol AuthProvider {
    func accessToken() async throws -> String
    func refreshAuth() async throws
}
