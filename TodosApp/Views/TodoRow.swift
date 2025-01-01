//
//  TodoRow.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import SwiftUI

struct TodoRow: View {
    @Bindable var todo: Todo
    
    var body: some View {
        HStack {
            Text(todo.title)
            Spacer()
            Toggle("Complete", isOn: $todo.isComplete)
        }
    }
}
