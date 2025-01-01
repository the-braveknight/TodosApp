//
//  PaginatedResponse.swift
//  TodosApp
//
//  Created by Zaid Rahhawi on 12/29/24.
//

import Foundation

struct PaginatedResponse<Item> {
    let items: [Item]
    let pagination: PaginationMetadata
}

struct PaginationMetadata {
    let currentPage: Int
    let totalPages: Int
    let totalCount: Int
    let recordsPerPage: Int
    
    init(totalCount: Int, totalPages: Int, recordsPerPage: Int, currentPage: Int) {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.totalCount = totalCount
        self.recordsPerPage = recordsPerPage
    }
    
    init(from httpURLResponse: HTTPURLResponse) throws {
        guard let currentPage = httpURLResponse.value(forHTTPHeaderField: "x-page") else {
            throw PaginationError.missingHeader(key: "x-page")
        }
        
        guard let currentPage = Int(currentPage) else {
            throw PaginationError.invalidHeader(key: "x-page")
        }
        
        guard let totalPages = httpURLResponse.value(forHTTPHeaderField: "x-total-pages") else {
            throw PaginationError.missingHeader(key: "x-total-pages")
        }
        
        guard let totalPages = Int(totalPages) else {
            throw PaginationError.invalidHeader(key: "x-total-pages")
        }
        
        guard let totalCount = httpURLResponse.value(forHTTPHeaderField: "x-total-count") else {
            throw PaginationError.missingHeader(key: "x-total-count")
        }
        
        guard let totalCount = Int(totalCount) else {
            throw PaginationError.invalidHeader(key: "x-total-count")
        }
        
        guard let perPage = httpURLResponse.value(forHTTPHeaderField: "x-limit") else {
            throw PaginationError.missingHeader(key: "x-limit")
        }
        
        guard let perPage = Int(perPage) else {
            throw PaginationError.invalidHeader(key: "x-limit")
        }
        
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.totalCount = totalCount
        self.recordsPerPage = perPage
    }
}

extension PaginationMetadata {
    var firstPage: Int {
        return 1
    }
    
    var lastPage: Int {
        return totalPages
    }
    
    var nextPage: Int? {
        guard currentPage < totalPages else {
            return nil
        }
        
        return currentPage + 1
    }
    
    var previousPage: Int? {
        guard currentPage > 1 else {
            return nil
        }
        
        return currentPage - 1
    }
}

enum PaginationError: Error {
    case missingHeader(key: String)
    case invalidHeader(key: String)
}
