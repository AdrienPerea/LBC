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

    static var mock: Annonce {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = -1
        return Annonce(
            id: 321,
            categoryID: 1,
            title: "Title assez long pour voir sur plusieurs lignes et sur 3 ligne peut etre",
            description: "description c'est tres gros une description d'article sur le bon coin bla bla bla on dit plein de choses nanana uan aufn of oef aoeifj aoiefj aopijf oiaejf oaiejf aoiejf aoefij aoeifj aoefij aoeifj aoeifj aoeifjaoeifj aoefj aoefi \n\njaoef ijaoefij aoefi jaoefji aoefi j\n azdija opzdjoa izjd oi\nazdjaozdjaoijzoiajzd description c'est tres gros une description d'article sur le bon coin bla bla bla on dit plein de choses nanana uan aufn of oef aoeifj aoiefj aopijf oiaejf oaiejf aoiejf aoefij aoeifj aoefij aoeifj aoeifj aoeifjaoeifj aoefj aoefi \n\njaoef ijaoefij aoefi jaoefji aoefi j\n azdija opzdjoa izjd oi\nazdjaozdjaoijzoiajzd description c'est tres gros une description d'article sur le bon coin bla bla bla on dit plein de choses nanana uan aufn of oef aoeifj aoiefj aopijf oiaejf oaiejf aoiejf aoefij aoeifj aoefij aoeifj aoeifj aoeifjaoeifj aoefj aoefi \n\njaoef ijaoefij aoefi jaoefji aoefi j\n azdija opzdjoa izjd oi\nazdjaozdjaoijzoiajzd",
            price: 55,
            imagesURL: ImagesURL(
                small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
                thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"
            ),
            creationDate: Date().toString,
            isUrgent: true,
            siret: "192 192 192 192"
        )
    }
}

// MARK: - ImagesURL
struct ImagesURL: Codable {
    let small: String?
    let thumb: String?
}

typealias Annonces = [Annonce]
