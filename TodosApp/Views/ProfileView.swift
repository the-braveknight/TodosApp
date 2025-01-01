//
//  ProfileView.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.logout) private var logout
    @Environment(User.self) private var user
    
    var body: some View {
        NavigationStack {
            Form {
                Section("User") {
                    LabeledContent("First Name", value: user.firstName)
                    LabeledContent("Last Name", value: user.lastName)
                    LabeledContent("Email", value: user.email)
                }
                
                Section {
                    Button("Logout", action: logoutCurrentUser)
                }
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
