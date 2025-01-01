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
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(stringLiteral: title)
    }
    
    init(title: String, id: Todo.ID) {
        self.title = title
        self.id = id
    }
    
    init(todo: Todo) {
        self.init(title: todo.title, id: todo.id)
    }
}
