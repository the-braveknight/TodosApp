//
//  StoredKey.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 1/1/25.
//

import Foundation

public protocol StoredKey {
    static var key: String { get }
    associatedtype Value: Codable
}
