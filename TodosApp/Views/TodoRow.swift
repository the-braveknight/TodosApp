//
//  TodoRow.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

struct TodoRow: View {
    @Bindable var todo: Todo
    @Environment(\.todoService) var service
    
    var body: some View {
        HStack() {
            Text(todo.title)
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Toggle("Complete", isOn: $todo.isComplete)
                .toggleStyle(.checkmark)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .task(id: todo.isComplete, priority: .background, update)
    }
    
    @Sendable private func update() async {
        guard todo.hasChanges else {
            return
        }
        
        do {
            let payload = Todo.Patch(title: todo.title, isComplete: todo.isComplete)
            try await service.patch(id: todo.id, payload: payload)
        } catch {
            print("Error updating todo: \(error).")
        }
    }
}

extension Todo {
    static let example = Todo(id: UUID(), title: "Do something.", isComplete: false)
}

#Preview {
    List {
        TodoRow(todo: .example)
    }
}
