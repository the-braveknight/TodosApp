//
//  TodoService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

protocol TodoService: Sendable {
    func fetchTodos(page: Int, todosPerPage: Int) async throws -> PaginatedResponse<Todo>
    func patch(id: Todo.ID, payload: Todo.Patch) async throws
    func delete(id: Todo.ID) async throws
    func create(payload: Todo.Create) async throws -> Todo
}
