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
    
    @State private var isCreatingTodo: Bool = false
    @State private var pagination: PaginationMetadata?
    
    @Environment(\.todoService) private var service
    @Environment(\.modelContext) private var modelContext
    @Environment(\.requestAuthorization) private var requestAuthorization
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    TodoRow(todo: todo)
                }
                .onDelete(perform: deleteTodos)
            }
            .navigationTitle("Todos")
            .task(fetchInitialTodos)
            .refreshable(action: fetchInitialTodos)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isCreatingTodo = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isCreatingTodo) {
            CreateTodoView()
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
    
    private func deleteTodos(at offsets: IndexSet) {
        offsets.forEach { index in
            delete(todo: todos[index])
        }
    }
    
    private func delete(todo: Todo) {
        Task {
            do {
                try await service.delete(id: todo.id)
                modelContext.delete(todo)
                try modelContext.save()
            } catch {
                print("Error deleting todo: \(error.localizedDescription).")
            }
        }
    }
}
