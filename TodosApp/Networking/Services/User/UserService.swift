//
//  UserService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/31/24.
//

protocol UserService {
    func fetchUser() async throws -> User
}
