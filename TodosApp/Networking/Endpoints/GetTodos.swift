//
//  GetTodos.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Melatonin

struct GetTodos: Endpoint {
    let page: Int
    let todosPerPage: Int
    
    var call: some HTTPCall {
        VaporCall()
            .path("/todos")
            .queries {
                Query(name: "page", value: String(page))
                Query(name: "per", value: String(todosPerPage))
            }
    }
}
