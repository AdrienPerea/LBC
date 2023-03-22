//
//  AnnonceRepository.swift
//  LBC
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

class AnnonceRepository {

    private var annonceAPI: AnnonceAPI!

    init() {
        annonceAPI = AnnonceAPI()
    }

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

    func fetchAnnonces(completion: @escaping (Result<Annonces, Error>) -> Void) {
        annonceAPI.fetchAnnonces { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let annonces = try decoder.decode(Annonces.self, from: data)
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
