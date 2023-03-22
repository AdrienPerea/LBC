//
//  Annonce.swift
//  LBC
//
//  Created by Adrien PEREA on 21/03/2023.
//

import Foundation

// MARK: - Annonce
struct Annonce: Codable {
    let id: Int
    let category: String
    let title: String
    let description: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?

    init(id: Int, category: String, title: String, description: String, price: Int, imagesURL: ImagesURL, creationDate: String, isUrgent: Bool, siret: String?) {
        self.id = id
        self.category = category
        self.title = title
        self.description = description
        self.price = price
        self.imagesURL = imagesURL
        self.creationDate = creationDate
        self.isUrgent = isUrgent
        self.siret = siret
    }

}

typealias Annonces = [Annonce]
