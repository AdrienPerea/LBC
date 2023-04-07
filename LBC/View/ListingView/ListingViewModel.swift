//
//  ListingViewModel.swift
//  LBC
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

class ListingViewModel {

    // MARK: - Properties

    var reloadHandler: () -> Void = { }
    var annonces: Annonces = []
    var categories: Categories = []

    // MARK: - Private properties

    private var repository: AnnonceRepositoryProtocol

    // MARK: - Init

    init(repository: AnnonceRepositoryProtocol = AnnonceRepository.shared) {
        self.repository = repository
    }

    // MARK: - Methods

    func fetchDatas() {
        fetchCategories()
    }

    // MARK: - Private methods

    private func fetchCategories() {
        // in case we have a pull to request and the first call for category don't need to be reused casue the don't change frequently
        if categories.isEmpty {
            repository.fetchData(endpoint: .categories) { [weak self] (result: Result<Categories, Error>) in
                guard let me = self else { return }
                switch result {
                case .success(let categories):
                    me.categories = categories
                    me.fetchAnnonces()
                case .failure(let error):
                    print(error.localizedDescription)
                    me.reloadHandler()
                }
            }
        } else {
            fetchAnnonces()
        }
    }

    private func fetchAnnonces() {
        repository.fetchData(endpoint: .annonces) { [weak self] (result: Result<AnnoncesResponses, Error>) in
            guard let me = self else { return }
            switch result {
            case .success(let annoncesResponses):
                let annonces = annoncesResponses.map { annonceResponse -> Annonce in
                    return Annonce(
                        id: annonceResponse.id,
                        category: me.returnCategoryName(categoryId: annonceResponse.categoryID),
                        title: annonceResponse.title,
                        description: annonceResponse.description,
                        price: annonceResponse.price,
                        imagesURL: annonceResponse.imagesURL,
                        creationDate: annonceResponse.creationDate,
                        isUrgent: annonceResponse.isUrgent,
                        siret: annonceResponse.siret)
                }
                me.annonces = annonces
            case .failure(let error):
                print(error.localizedDescription)
            }
            me.reloadHandler()
        }
    }

    private func returnCategoryName(categoryId: Int) -> String {
        if let category = categories.first(where: { $0.id == categoryId }) {
            return category.name
        }
        return "no category"
    }

}
