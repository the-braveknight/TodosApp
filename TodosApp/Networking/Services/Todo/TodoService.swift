//
//  TodoService.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

protocol TodoService {
    func fetchTodos(page: Int, todosPerPage: Int) async throws -> PaginatedResponse<Todo>
}
