//
//  User.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Foundation

struct User: Codable {
    let id: UUID
    let email: String
    let firstName: String
    let lastName: String
}
