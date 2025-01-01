//
//  Todo+Patch.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

extension Todo {
    struct Patch: Encodable {
        let title: String
        let isComplete: Bool
    }
}
