//
//  TodosApp.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI
import SwiftData

@main
struct TodosApp: App {
    private let modelContainer: ModelContainer
    private let authManager: AuthManager
    private let userService: UserService
    private let todoService: TodoService
    
    @State private var showLoginScreen: Bool = true
    @State private var user: User?
    
    init() {
        do {
            let modelContainer = try ModelContainer(for: Todo.self)
            self.modelContainer = modelContainer
        } catch {
            fatalError("Error initializing SwiftData model container: \(error).")
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = false
        let session = URLSession(configuration: configuration)
        
        let keychain = Keychain(serviceName: "TodosApp", accessGroup: nil)
        let keychainStorage = KeychainStorage(keychain: keychain)
        let authService = HTTPAuthService(session: session)
        let authManager = AuthManager(authService: authService, authStorage: keychainStorage)
        
        self.authManager = authManager
        self.todoService = HTTPTodoService(session: session, authProvider: authManager)
        self.userService = HTTPUserService(session: session, authProvider: authManager)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .fullScreenCover(isPresented: $showLoginScreen) {
                    LoginView()
                }
        }
        .modelContainer(modelContainer)
        .environment(\.todoService, todoService)
        .environment(\.user, user)
        .environment(\.login, LoginAction(action: login))
        .environment(\.logout, LogoutAction(action: logout))
        .environment(\.requestAuthorization, RequestAuthorizationAction(action: requestAuthorization))
    }
    
    private func requestAuthorization() {
        showLoginScreen = true
    }
    
    private func login(username: String, password: String) async throws {
        try await authManager.login(username: username, password: password)
        self.user = try await userService.fetchUser()
        showLoginScreen = false
    }
    
    private func logout() async throws {
        self.user = nil
        try await authManager.logout()
        showLoginScreen = true
    }
}
