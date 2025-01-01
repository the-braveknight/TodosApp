//
//  CreateTodo.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Melatonin

struct CreateTodo: Endpoint {
    let payload: Todo.Create
    
    var call: some HTTPCall {
        VaporCall()
            .path("/todos")
            .method(.post)
            .contentType(.json)
            .body(body: payload)
    }
}
