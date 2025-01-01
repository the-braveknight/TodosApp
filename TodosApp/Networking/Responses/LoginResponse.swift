//
//  LoginResponse.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

struct LoginResponse: Decodable {
    let auth: Auth
    let user: User
}
