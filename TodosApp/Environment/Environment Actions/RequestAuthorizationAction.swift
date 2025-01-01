//
//  RequestAuthorizationAction.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/31/24.
//

import SwiftUI

struct RequestAuthorizationAction {
    let action: () -> Void
    
    func callAsFunction() {
        action()
    }
}

extension EnvironmentValues {
    @Entry var requestAuthorization = RequestAuthorizationAction(action: log)
}

private func log() {
    print("Requesting authorization...")
}
