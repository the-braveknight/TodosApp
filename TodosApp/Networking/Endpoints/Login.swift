//
//  Login.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Melatonin

struct Login: Endpoint {
    var call: some HTTPCall {
        VaporCall()
            .method(.post)
            .path("/auth/login")
    }
}
