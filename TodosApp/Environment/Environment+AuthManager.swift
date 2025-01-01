//
//  Environment+AuthManager.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var authManager = AuthManager(authService: HTTPAuthService(session: .shared), authStorage: .inMemory)
}
