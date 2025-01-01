//
//  PatchTodo.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation
import Melatonin

struct PatchTodo: Endpoint {
    let id: Todo.ID
    let payload: Todo.Patch
    
    var call: some HTTPCall {
        VaporCall()
            .path("/todos/\(id.uuidString)")
            .method(.patch)
            .contentType(.json)
            .body(body: payload)
    }
}
