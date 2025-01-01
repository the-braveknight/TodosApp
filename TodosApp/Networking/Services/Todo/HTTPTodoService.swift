//
//  HTTPTodoService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Melatonin
import Foundation

actor HTTPTodoService: TodoService, AuthorizedHTTPService {
    let session: URLSession
    let authProvider: AuthProvider
    
    init(session: URLSession, authProvider: AuthProvider) {
        self.session = session
        self.authProvider = authProvider
    }
    
    func fetchTodos(page: Int, todosPerPage: Int) async throws -> PaginatedResponse<Todo> {
        let endpoint = GetTodos(page: page, todosPerPage: todosPerPage)
        let (data, response) = try await loadWithAuth(endpoint.call)
        let paginationMetadata = try PaginationMetadata(from: response)
        let decoder = JSONDecoder()
        let todos = try decoder.decode([Todo].self, from: data)
        return PaginatedResponse(items: todos, pagination: paginationMetadata)
    }
    
    func delete(id: Todo.ID) async throws {
        let endpoint = DeleteTodo(id: id)
        let (_, response) = try await loadWithAuth(endpoint.call)
        guard response.statusCode == 204 else {
            throw URLError(.badServerResponse)
        }
    }
    
    func patch(id: Todo.ID, payload: Todo.Patch) async throws {
        let endpoint = PatchTodo(id: id, payload: payload)
        let (_, response) = try await loadWithAuth(endpoint.call)
        guard response.statusCode == 204 else {
            throw URLError(.badServerResponse)
        }
    }
    
    func create(payload: Todo.Create) async throws -> Todo {
        let endpoint = CreateTodo(payload: payload)
        let (data, _) = try await loadWithAuth(endpoint.call)
        let decoder = JSONDecoder()
        return try decoder.decode(Todo.self, from: data)
    }
}
