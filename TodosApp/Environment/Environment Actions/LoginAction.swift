//
//  LoginAction.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

struct LoginAction {
    let action: (String, String) async throws -> Void
    
    func callAsFunction(email: String, password: String) async throws {
        try await action(email, password)
    }
}

extension EnvironmentValues {
    @Entry var login: LoginAction = LoginAction(action: log)
}

private func log(username: String, password: String) async throws {
    print("Attempting to login with username: \(username), password: \(password).")
}
