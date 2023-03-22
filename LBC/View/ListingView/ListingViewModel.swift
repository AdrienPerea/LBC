//
//  ListingViewModel.swift
//  LBC
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

class ListingViewModel {

    var reloadHandler: () -> Void = { }
    private var repository: AnnonceRepository!
    var annonces: Annonces = []
    var categories: Categories = []

    init() {
        repository = AnnonceRepository()
    }

    func fetchCategories() {
        repository.fetchCategories { [weak self] result in
            guard let me = self else { return }
            switch result {
            case .success(let categories):
                me.categories = categories
            case .failure(let error):
                print(error.localizedDescription)
            }
            me.reloadHandler()
        }
    }

    func fetchAnnonces() {
        repository.fetchAnnonces { [weak self] result in
            guard let me = self else { return }
            switch result {
            case .success(let annonces):
                me.annonces = annonces
            case .failure(let error):
                print(error.localizedDescription)
            }
            me.reloadHandler()
        }
    }
    
    func returnCategoryName(categoryId: Int) -> String? {
        if let category = categories.first(where: { $0.id == categoryId }) {
            return category.name
        }
        return nil
    }

}
