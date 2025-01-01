//
//  Todo+Create.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

extension Todo {
    struct Create: Encodable {
        let title: String
        var isComplete: Bool = false
    }
}
