//
//  HTTPError.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Foundation

struct HTTPError: Error {
    let code: Code
    
    init(_ code: Code) {
        self.code = code
    }
}

extension HTTPError {
    enum Code: Int {
        case unauthorized
    }
}
