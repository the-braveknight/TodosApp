//
//  MockTodoService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

final class MockTodoService: TodoService, @unchecked Sendable {
    private var todos = [
        Todo(id: UUID(), title: "Todo #1", isComplete: true),
        Todo(id: UUID(), title: "Todo #2", isComplete: false),
        Todo(id: UUID(), title: "Todo #3", isComplete: true),
    ]
    
    func fetchTodos(page: Int, todosPerPage: Int) async throws -> PaginatedResponse<Todo> {
        let pagination = PaginationMetadata(totalCount: 3, totalPages: 1, recordsPerPage: 10, currentPage: 1)
        return PaginatedResponse(items: todos, pagination: pagination)
    }
    
    func patch(id: Todo.ID, payload: Todo.Patch) async throws {
        // Do nothing
        guard let todo = todos.first(where: { $0.id == id }) else {
            return
        }
        
        todo.title = payload.title
        todo.isComplete = payload.isComplete
    }
    
    func delete(id: Todo.ID) async throws {
        // Do nothing
        guard let index = todos.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        todos.remove(at: index)
    }
    
    func create(payload: Todo.Create) async throws -> Todo {
        let todo = Todo(id: UUID(), title: payload.title, isComplete: payload.isComplete)
        todos.append(todo)
        return todo
    }
}
