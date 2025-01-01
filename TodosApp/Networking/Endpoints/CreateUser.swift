//
//  CreateUser.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Melatonin

struct CreateUser: Endpoint {
    let payload: Payload
    
    var call: some HTTPCall {
        VaporCall()
            .method(.post)
            .body(body: payload)
    }
}

extension CreateUser {
    struct Payload: Encodable {
        let firstName: String
        let lastName: String
        let email: String
        let password: String
        let confirmPassword: String
    }
}
