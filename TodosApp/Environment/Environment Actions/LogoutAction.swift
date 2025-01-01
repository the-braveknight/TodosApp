//
//  LogoutAction.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

struct LogoutAction {
    let action: () async throws -> Void
    
    func callAsFunction() async throws {
        try await action()
    }
}

extension EnvironmentValues {
    @Entry var logout = LogoutAction(action: log)
}

private func log() {
    print("Logging out...")
}
