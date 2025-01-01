//
//  TodoEntity.swift
//  Example
//
//  Created by Zaid Rahhawi on 27/06/2024.
//

import AppIntents

struct TodoEntity: AppEntity {
    static let defaultQuery = TodoEntityQuery()
    static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Todo")
    
    let id: Todo.ID
    let title: String
    let isComplete: Bool
    
    var displayRepresentation: DisplayRepresentation {
        let title = LocalizedStringResource(stringLiteral: title)
        let image = DisplayRepresentation.Image(systemName: isComplete ? "checkmark.circle" : "circle")
        return DisplayRepresentation(title: title, image: image)
    }
    
    init(title: String, id: Todo.ID, isComplete: Bool) {
        self.title = title
        self.id = id
        self.isComplete = isComplete
    }
    
    init(todo: Todo) {
        self.init(title: todo.title, id: todo.id, isComplete: todo.isComplete)
    }
}
