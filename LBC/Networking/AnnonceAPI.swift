//
//  AnnonceAPI.swift
//  LBC
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

class AnnonceAPI {

    func fetchCategories(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "AnnonceAPIErrorDomain", code: 1, userInfo: nil)))
                return
            }
            completion(.success(data))
        }.resume()
    }

    func fetchAnnonces(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "AnnonceAPIErrorDomain", code: 1, userInfo: nil)))
                return
            }
            completion(.success(data))
        }.resume()
    }

}
