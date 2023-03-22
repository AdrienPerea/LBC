//
//  Category.swift
//  LBC
//
//  Created by Adrien PEREA on 21/03/2023.
//

import Foundation

struct Category: Codable {

    // MARK: - Properties

    let id: Int
    let name: String

    // MARK: - Init

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

typealias Categories = [Category]
