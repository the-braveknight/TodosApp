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
    
    @Environment(\.login) var login
//    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            Button("Login", action: loginWithCurrentCredentials)
        }
    }
    
    private func loginWithCurrentCredentials() {
        Task {
            do {
                try await login(email: email, password: password)
//                dismiss()
            } catch {
                print(error)
            }
        }
    }
}
