//
//  AnnonceRepository.swift
//  LBC
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

protocol AnnonceRepositoryProtocol {
    func fetchCategories(completion: @escaping (Result<Categories, Error>) -> Void)
    func fetchAnnonces(completion: @escaping (Result<AnnoncesResponses, Error>) -> Void)
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

    func fetchCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        annonceAPI.fetchCategories { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let annonces = try decoder.decode(Categories.self, from: data)
                    completion(.success(annonces))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchAnnonces(completion: @escaping (Result<AnnoncesResponses, Error>) -> Void) {
        annonceAPI.fetchAnnonces { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let annonces = try decoder.decode(AnnoncesResponses.self, from: data)
                    completion(.success(annonces))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
