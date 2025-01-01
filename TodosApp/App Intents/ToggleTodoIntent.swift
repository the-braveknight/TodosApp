//
//  ToggleTodoIntent.swift
//  Example
//
//  Created by Zaid Rahhawi on 27/06/2024.
//

import AppIntents
import SwiftData

struct ToggleTodoIntent: AppIntent {
    static let title: LocalizedStringResource = "Toggle Todo"
    static let openAppWhenRun: Bool = false
    
    @Parameter(title: "Todo") var todo: TodoEntity
    
    @Dependency private var modelContainer: ModelContainer
    @Dependency private var service: TodoService
    
    static var parameterSummary: some ParameterSummary {
        Summary("Todo \(\.$todo)")
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        let id = todo.id
        let predicate = #Predicate<Todo> { $0.id == id }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        let query = try modelContainer.mainContext.fetch(fetchDescriptor)
        
        if let todo = query.first {
            let payload = Todo.Patch(title: todo.title, isComplete: todo.isComplete)
            try await service.patch(id: todo.id, payload: payload)
            try modelContainer.mainContext.save()
            todo.isComplete.toggle()
        }
        
        return .result()
    }
}
