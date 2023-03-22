//
//  AnnonceAPI.swift
//  LBC
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

protocol AnnonceApiProtocol {
    func fetchCategories(completion: @escaping (Result<Data, Error>) -> Void)
    func fetchAnnonces(completion: @escaping (Result<Data, Error>) -> Void)
}

protocol NetworkEngine {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    func performRequest(for url: URL, completionHandler: @escaping Handler)
}

class AnnonceAPI: AnnonceApiProtocol {

    // MARK: - Init

    init(engine: NetworkEngine = URLSession.shared) {
        self.networkEngine = engine
    }

    // MARK: - Private properties

    private let apiPath: String = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    private var networkEngine: NetworkEngine

    enum endPoint {
        case categories
        case annonces

        var url: String {
            switch self {
            case .annonces:
                return "listing.json"
            case .categories:
                return "categories.json"
            }
        }
    }

    // MARK: - Methods

    func fetchCategories(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: apiPath + endPoint.categories.url)!
        networkEngine.performRequest(for: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "AnnonceAPIErrorDomain", code: 1, userInfo: nil)))
                return
            }
            completion(.success(data))
        }
    }

    func fetchAnnonces(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: apiPath + endPoint.annonces.url)!
        networkEngine.performRequest(for: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "AnnonceAPIErrorDomain", code: 1, userInfo: nil)))
                return
            }
            completion(.success(data))
        }
    }

}
