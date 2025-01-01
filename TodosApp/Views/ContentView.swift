//
//  ContentView.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(User.self) private var user: User
    @Environment(\.logout) private var logout
    
    var body: some View {
        TabView {
            Tab("Todos", systemImage: "checklist") {
                TodosView()
            }
            
            Tab(user.firstName, systemImage: "person.circle") {
                ProfileView()
            }
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
