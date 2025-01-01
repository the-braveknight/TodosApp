//
//  VaporCall.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Foundation
import Melatonin

struct VaporCall: HTTPCall {
    func build() -> URLRequest {
        URLRequest(url: .localVaporServerURL)
    }
}

private extension URL {
    static let localVaporServerURL = URL(string: "http://localhost:8080")!
    static let rpiVaporServerURL = URL(string: "http://zrahawi-desktop.local:8080")!
}
