//
//  AnnonceAPI.swift
//  LBC
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

class AnnonceAPI {
    
    private var categoryTask: URLSessionTask?
    private var annonceTask: URLSessionTask?
    private var urlSession: URLSession

    // MARK: - Init

    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }

    func fetchCategories(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!
        categoryTask?.cancel()
        categoryTask = urlSession.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "AnnonceAPIErrorDomain", code: 1, userInfo: nil)))
                return
            }
            completion(.success(data))
        })
        categoryTask?.resume()
    }

    func fetchAnnonces(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!
        annonceTask?.cancel()
        annonceTask = urlSession.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "AnnonceAPIErrorDomain", code: 1, userInfo: nil)))
                return
            }
            completion(.success(data))
        })
        annonceTask?.resume()
    }

}
