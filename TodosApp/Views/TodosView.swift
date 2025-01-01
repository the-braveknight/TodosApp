//
//  TodosView.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI
import SwiftData

struct TodosView: View {
    @Query private var todos: [Todo]
    @State private var pagination: PaginationMetadata?
    
    @Environment(\.todoService) private var service
    @Environment(\.modelContext) private var modelContext
    @Environment(\.requestAuthorization) private var requestAuthorization
    
    var body: some View {
        NavigationStack {
            List(todos) { todo in
                TodoRow(todo: todo)
                    .task {
                        if todo.id == todos.last?.id {
                            await fetchNextPage()
                        }
                    }
            }
            .navigationTitle("Todos")
            .task(fetchInitialTodos)
            .refreshable(action: fetchInitialTodos)
        }
    }
    
    @Sendable private func fetchInitialTodos() async {
        await fetchTodos(page: 1, todosPerPage: 10)
    }
    
    @Sendable private func fetchNextPage() async {
        guard let nextPage = pagination?.nextPage else { return }
        
        await fetchTodos(page: nextPage, todosPerPage: 10)
    }
    
    private func fetchTodos(page: Int, todosPerPage: Int) async {
        do {
            let response = try await service.fetchTodos(page: page, todosPerPage: todosPerPage)
            self.pagination = response.pagination
            
            for todo in response.items {
                modelContext.insert(todo)
            }
            
            try modelContext.save()
        } catch let error as HTTPError {
            if error.code == .unauthorized {
                requestAuthorization()
            }
        } catch {
            print("Error fetching todos: \(error.localizedDescription).")
        }
    }
}
