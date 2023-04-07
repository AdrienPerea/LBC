//
//  AnnonceResponse.swift
//  LBC
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

struct AnnonceResponse: Decodable {

    // MARK: - Properties

    let id: Int
    let categoryID: Int
    let title: String
    let description: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case description
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }

    // MARK: - Init

    init(id: Int, categoryID: Int, title: String, description: String, price: Int, imagesURL: ImagesURL, creationDate: String, isUrgent: Bool, siret: String?) {
        self.id = id
        self.categoryID = categoryID
        self.title = title
        self.description = description
        self.price = price
        self.imagesURL = imagesURL
        self.creationDate = creationDate
        self.isUrgent = isUrgent
        self.siret = siret
    }
}

struct ImagesURL: Decodable {
    let small: String?
    let thumb: String?
}

typealias AnnoncesResponses = [AnnonceResponse]
