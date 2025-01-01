//
//  LoginView.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = "zaid.riadh@gmail.com"
    @State private var password: String = "zaid@root99"
    
    @Environment(\.login) private var login
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            Button("Login", action: loginWithCurrentCredentials)
                .font(.headline)
        }
    }
    
    private func loginWithCurrentCredentials() {
        Task {
            do {
                try await login(email: email, password: password)
            } catch {
                print(error)
            }
        }
    }
}
