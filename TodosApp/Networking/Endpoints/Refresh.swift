//
//  Refresh.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Melatonin

struct Refresh: Endpoint {
    var call: some HTTPCall {
        VaporCall()
            .path("/auth/refresh")
            .method(.post)
    }
}
