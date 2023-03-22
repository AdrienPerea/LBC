//
//  Category.swift
//  LBC
//
//  Created by Adrien PEREA on 21/03/2023.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

typealias Categories = [Category]
