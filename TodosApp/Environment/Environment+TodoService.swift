//
//  Environment+TodoService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var todoService: TodoService = HTTPTodoService(session: .shared, authProvider: AuthManager(authService: HTTPAuthService(session: .shared), authStorage: .inMemory))
}
