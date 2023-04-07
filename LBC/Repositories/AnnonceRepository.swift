//
//  AnnonceRepository.swift
//  LBC
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

protocol AnnonceRepositoryProtocol {
    func fetchData<T:Decodable>(endpoint: AnnonceAPI.endPoint, completion: @escaping (Result<T, Error>) -> Void)
}

class AnnonceRepository: AnnonceRepositoryProtocol {

    // MARK: - Properties

    static let shared = AnnonceRepository()
    var annonceAPI: AnnonceApiProtocol!

    // MARK: - Private init

    private init(annonceAPI: AnnonceApiProtocol = AnnonceAPI()) {
        self.annonceAPI = annonceAPI
    }

    // MARK: - Methods
    
    func fetchData<T:Decodable>(endpoint: AnnonceAPI.endPoint, completion: @escaping (Result<T, Error>) -> Void) {
        annonceAPI.fetchData(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
