//
//  AuthService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

protocol AuthService {
    func requestAuthorization(email: String, password: String) async throws -> Auth
    func requestAuthorization(refreshToken: String) async throws -> Auth
}
