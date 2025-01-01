//
//  CreateTodoView.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import SwiftUI

struct CreateTodoView: View {
    @State private var title: String = ""
    @State private var isComplete: Bool = false
    
    @State private var isLoading: Bool = false
    
    @Environment(\.todoService) private var service
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    TextField("Title", text: $title, axis: .vertical)
                    Toggle("Complete", isOn: $isComplete)
                        .toggleStyle(.checkmark)
                }
                
                Section {
                    Button("Create", action: create)
                        .font(.headline)
                }
            }
            .navigationTitle("Create Todo")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Dismiss", action: dismiss.callAsFunction)
                        .disabled(isLoading)
                }
            }
        }
        .interactiveDismissDisabled(isLoading)
    }
    
    private func create() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                let payload = Todo.Create(title: title, isComplete: isComplete)
                let createdTodo = try await service.create(payload: payload)
                modelContext.insert(createdTodo)
                try modelContext.save()
                dismiss()
            } catch {
                print("Error creating todo: \(error).")
            }
        }
    }
}
