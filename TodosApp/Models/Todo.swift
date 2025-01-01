//
//  Todo.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Foundation
import SwiftData

@Model
final class Todo: Identifiable, Decodable {
    @Attribute(.unique) var id: UUID
    var title: String
    var isComplete: Bool = false
    
    init(id: UUID, title: String, isComplete: Bool) {
        self.id = id
        self.title = title
        self.isComplete = isComplete
    }
    
    // MARK: - Decodable Conformance
    
    private enum CodingKeys: String, CodingKey {
        case id, title, isComplete
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.isComplete = try container.decode(Bool.self, forKey: .isComplete)
    }
}
