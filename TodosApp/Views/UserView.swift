//
//  UserView.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    @Environment(\.logout) var logout
    
    var body: some View {
        NavigationStack {
            Form {
                Button("Logout", action: logoutCurrentUser)
            }
            .navigationTitle("Hello, \(user.firstName)!")
        }
    }
    
    private func logoutCurrentUser() {
        Task {
            try await logout()
        }
    }
}
