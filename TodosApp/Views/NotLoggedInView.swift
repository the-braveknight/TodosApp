//
//  NotLoggedInView.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import SwiftUI

struct NotLoggedInView: View {
    @Environment(\.requestAuthorization) private var requestAuthorization
    
    var body: some View {
        VStack {
            Text("Not Logged In")
                .font(.headline)
            
            Button("Login", action: requestAuthorization.callAsFunction)
                .foregroundStyle(.white)
                .font(.headline)
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    @Previewable @State var isLoginScreenPresented: Bool = false
    
    var requestAuthorization: RequestAuthorizationAction {
        RequestAuthorizationAction {
            isLoginScreenPresented = true
        }
    }
    
    NotLoggedInView()
        .environment(\.requestAuthorization, requestAuthorization)
        .sheet(isPresented: $isLoginScreenPresented) {
            LoginView()
        }
}
