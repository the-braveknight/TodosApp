//
//  TodosApp.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI
import SwiftData
import StorageKit
import AppIntents

@main
struct TodosApp: App {
    private let modelContainer: ModelContainer
    private let authManager: AuthManager
    private let userService: UserService
    private let todoService: TodoService
    
    @State private var showLoginScreen: Bool = false
    @State private var user: User?
    
    init() {
        do {
            let modelContainer = try ModelContainer(for: Todo.self, User.self)
            self.modelContainer = modelContainer
            AppDependencyManager.shared.add(dependency: modelContainer)
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
        let todoService: TodoService = HTTPTodoService(session: session, authProvider: authManager)
        self.todoService = todoService
        AppDependencyManager.shared.add(dependency: todoService)
        self.userService = HTTPUserService(session: session, authProvider: authManager)
        
        let fetchDescriptor = FetchDescriptor<User>()
        let cachedUser = try? modelContainer.mainContext.fetch(fetchDescriptor).first
        self._user = State(initialValue: cachedUser)
    }
    
    @ViewBuilder
    private var content: some View {
        if let user {
            ContentView()
                .environment(user)
        } else {
            NotLoggedInView()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            content
                .fullScreenCover(isPresented: $showLoginScreen) {
                    LoginView()
                }
        }
        .modelContainer(modelContainer)
        .environment(\.todoService, todoService)
        .environment(\.login, LoginAction(action: login))
        .environment(\.logout, LogoutAction(action: logout))
        .environment(\.requestAuthorization, RequestAuthorizationAction(action: requestAuthorization))
    }
    
    private func requestAuthorization() {
        showLoginScreen = true
    }
    
    private func login(username: String, password: String) async throws {
        if let loggedInUser = user {
            modelContainer.mainContext.delete(loggedInUser)
            try modelContainer.mainContext.save()
        }
        
        try await authManager.login(username: username, password: password)
        let user = try await userService.fetchUser()
        self.user = user
        modelContainer.mainContext.insert(user)
        try modelContainer.mainContext.save()
        showLoginScreen = false
    }
    
    private func logout() async throws {
        if let user {
            modelContainer.mainContext.delete(user)
            try modelContainer.mainContext.save()
        }
        
        self.user = nil
        try await authManager.logout()
    }
}

struct UserKey: StoredKey {
    static let key = "user"
    typealias Value = User
}
