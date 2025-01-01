//
//  DeleteTodo.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Melatonin

struct DeleteTodo: Endpoint {
    let id: Todo.ID
    
    var call: some HTTPCall {
        VaporCall()
            .path("/todos/\(id.uuidString)")
            .method(.delete)
    }
}
