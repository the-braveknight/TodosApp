//
//  GetUser.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Melatonin

struct GetUser: Endpoint {
    var call: some HTTPCall {
        VaporCall()
            .path("/user")
    }
}
