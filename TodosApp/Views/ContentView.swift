//
//  ContentView.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.user) private var user: User?
    @Environment(\.logout) private var logout
    
    var body: some View {
        if let user {
            TabView {
                Tab("Todos", systemImage: "checklist") {
                    TodosView()
                }
                
                Tab(user.firstName, systemImage: "person.circle") {
                    UserView(user: user)
                }
            }
        } else {
            Text("Not logged in.")
        }
    }
    
    private func logoutUser() {
        Task {
            try await logout()
        }
    }
}

#Preview {
    ContentView()
}
