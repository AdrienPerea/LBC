//
//  ListingViewModelTests.swift
//  LBCTests
//
//  Created by Adrien PEREA on 22/03/2023.
//

import XCTest
@testable import LBC

final class ListingViewModelTests: XCTestCase {

    // MARK: - TEST Fetch Datas

    func test_fetchDatas_withCategoriesSuccess_AndAnnoncesSuccess() {
        //given
        let categories: Categories = [Category(id: 1, name: "category1"), Category(id: 2, name: "category2")]
        let categoriesResult = Result<Categories, Error>.success(categories)
        
        let annonces: AnnoncesResponses = [
            AnnonceResponse(id: 1, categoryID: 1, title: "title1", description: "description1", price: 1, imagesURL: ImagesURL(small: "small1", thumb: "thumb1"), creationDate: Date().toString, isUrgent: true, siret: "111"),
            AnnonceResponse(id: 2, categoryID: 2, title: "title2", description: "description2", price: 2, imagesURL: ImagesURL(small: "small2", thumb: "thumb2"), creationDate: Date().toString, isUrgent: true, siret: "222")
        ]
        let annonceResult = Result<AnnoncesResponses, Error>.success(annonces)
        
        let annonceRepositoryMock = AnnonceRepositoryMock()
        annonceRepositoryMock.categoriesResult = categoriesResult
        annonceRepositoryMock.annoncesResult = annonceResult
        
        let listingViewModel = ListingViewModel(repository: annonceRepositoryMock)
        
        XCTAssertEqual(0, listingViewModel.categories.count)
        XCTAssertEqual(0, listingViewModel.annonces.count)
        
        listingViewModel.fetchDatas()

        XCTAssertEqual(2, listingViewModel.categories.count)
        XCTAssertEqual(2, listingViewModel.annonces.count)
        
        XCTAssertEqual(listingViewModel.annonces[0].category, "category1")
        XCTAssertEqual(listingViewModel.annonces[1].category, "category2")

        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 2), "category2")
        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 3), "no category")
    }
    
    func test_fetchDatas_withCategoriesFail_AndAnnoncesSuccess() {
        //given
        let error: Error = FakeApiData().error
        
        let annonces: AnnoncesResponses = [AnnonceResponse(id: 1, categoryID: 1, title: "title1", description: "description1", price: 1, imagesURL: ImagesURL(small: "small1", thumb: "thumb1"), creationDate: Date().toString, isUrgent: true, siret: "111")]
        
        let categoriesResult = Result<Categories, Error>.failure(error)
        let annonceResult = Result<AnnoncesResponses, Error>.success(annonces)

        let annonceRepositoryMock = AnnonceRepositoryMock()
        annonceRepositoryMock.categoriesResult = categoriesResult
        annonceRepositoryMock.annoncesResult = annonceResult
        
        let listingViewModel = ListingViewModel(repository: annonceRepositoryMock)
        
        XCTAssertEqual(0, listingViewModel.categories.count)
        XCTAssertEqual(0, listingViewModel.annonces.count)
        
        listingViewModel.fetchDatas()

        XCTAssertEqual(0, listingViewModel.categories.count)
        XCTAssertEqual(0, listingViewModel.annonces.count)

        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 1), "no category")
    }
    
    func test_fetchDatas_withCategoriesSuccess_andAnnoncesFail() {
        //given
        let categories: Categories = [Category(id: 1, name: "category1"), Category(id: 2, name: "category2")]
        let categoriesResult = Result<Categories, Error>.success(categories)
        
        let error: Error = FakeApiData().error
        let annonceResult = Result<AnnoncesResponses, Error>.failure(error)
        
        let annonceRepositoryMock = AnnonceRepositoryMock()
        annonceRepositoryMock.categoriesResult = categoriesResult
        annonceRepositoryMock.annoncesResult = annonceResult
        
        let listingViewModel = ListingViewModel(repository: annonceRepositoryMock)
        
        XCTAssertEqual(0, listingViewModel.categories.count)
        XCTAssertEqual(0, listingViewModel.annonces.count)
        
        listingViewModel.fetchDatas()
        
        XCTAssertEqual(2, listingViewModel.categories.count)
        XCTAssertEqual(0, listingViewModel.annonces.count)

        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 2), "category2")
        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 3), "no category")
    }
    
    func test_fetchDatas_withCategoriesFail_andAnnoncesFail() {
        //given
        let error: Error = FakeApiData().error
        
        let categoriesResult = Result<Categories, Error>.failure(error)
        let annonceResult = Result<AnnoncesResponses, Error>.failure(error)
        
        let annonceRepositoryMock = AnnonceRepositoryMock()
        annonceRepositoryMock.categoriesResult = categoriesResult
        annonceRepositoryMock.annoncesResult = annonceResult
        
        let listingViewModel = ListingViewModel(repository: annonceRepositoryMock)
        
        XCTAssertEqual(0, listingViewModel.categories.count)
        XCTAssertEqual(0, listingViewModel.annonces.count)
        
        listingViewModel.fetchDatas()
        
        XCTAssertEqual(0, listingViewModel.categories.count)
        XCTAssertEqual(0, listingViewModel.annonces.count)

        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 3), "no category")
    }
    
    func test_fetchDatas_withCategoriesSuccess_andAnnoncesSuccess_withCategoryAlreadyFetched() {
        //given
        let categories: Categories = [Category(id: 1, name: "category1"), Category(id: 2, name: "category2")]
        let categoriesResult = Result<Categories, Error>.success(categories)
        
        let annonces: AnnoncesResponses = [
            AnnonceResponse(id: 1, categoryID: 1, title: "title1", description: "description1", price: 1, imagesURL: ImagesURL(small: "small1", thumb: "thumb1"), creationDate: Date().toString, isUrgent: true, siret: "111"),
            AnnonceResponse(id: 2, categoryID: 2, title: "title2", description: "description2", price: 2, imagesURL: ImagesURL(small: "small2", thumb: "thumb2"), creationDate: Date().toString, isUrgent: true, siret: "222")
        ]
        let annonceResult = Result<AnnoncesResponses, Error>.success(annonces)
        
        let annonceRepositoryMock = AnnonceRepositoryMock()
        annonceRepositoryMock.categoriesResult = categoriesResult
        annonceRepositoryMock.annoncesResult = annonceResult
        
        let listingViewModel = ListingViewModel(repository: annonceRepositoryMock)
        listingViewModel.categories = [Category(id: 1, name: "category1")]
        
        XCTAssertEqual(1, listingViewModel.categories.count)
        XCTAssertEqual(0, listingViewModel.annonces.count)
        
        listingViewModel.fetchDatas()

        XCTAssertEqual(1, listingViewModel.categories.count)
        XCTAssertEqual(2, listingViewModel.annonces.count)
        
        XCTAssertEqual(listingViewModel.annonces[0].category, "category1")
        XCTAssertEqual(listingViewModel.annonces[1].category, "no category")

        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 2), "no category")
        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 1), "category1")
    }
    
    func test_fetchDatas_withCategoriesSuccess_andAnnoncesSuccess_withCategoryAlreadyFetched_andAnnonceAlreadyFetched() {
        //given
        let categories: Categories = [Category(id: 1, name: "category1"), Category(id: 2, name: "category2")]
        let categoriesResult = Result<Categories, Error>.success(categories)
        
        let annonces: AnnoncesResponses = [
            AnnonceResponse(id: 1, categoryID: 1, title: "title1", description: "description1", price: 1, imagesURL: ImagesURL(small: "small1", thumb: "thumb1"), creationDate: Date().toString, isUrgent: true, siret: "111"),
            AnnonceResponse(id: 2, categoryID: 2, title: "title2", description: "description2", price: 2, imagesURL: ImagesURL(small: "small2", thumb: "thumb2"), creationDate: Date().toString, isUrgent: true, siret: "222")
        ]
        let annonceResult = Result<AnnoncesResponses, Error>.success(annonces)
        
        let annonceRepositoryMock = AnnonceRepositoryMock()
        annonceRepositoryMock.categoriesResult = categoriesResult
        annonceRepositoryMock.annoncesResult = annonceResult
        
        let listingViewModel = ListingViewModel(repository: annonceRepositoryMock)
        listingViewModel.categories = [Category(id: 2, name: "category2")]
        listingViewModel.annonces = [Annonce(id: 1, category: "category1", title: "title1", description: "description1", price: 1, imagesURL: ImagesURL(small: "small1", thumb: "thumb1"), creationDate: Date().toString, isUrgent: true, siret: "111")]
        
        XCTAssertEqual(1, listingViewModel.categories.count)
        XCTAssertEqual(1, listingViewModel.annonces.count)
        
        listingViewModel.fetchDatas()

        XCTAssertEqual(1, listingViewModel.categories.count)
        XCTAssertEqual(2, listingViewModel.annonces.count)

        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 2), "category2")
        XCTAssertEqual(listingViewModel.returnCategoryName(categoryId: 1), "no category")
        XCTAssertEqual(listingViewModel.annonces[1].category, "category2")
    }

}
                                            
final class AnnonceRepositoryMock: AnnonceRepositoryProtocol {
            
    var categoriesResult: Result<Categories, Error> = Result<Categories, Error>.failure(FakeApiData().error)
    var annoncesResult: Result<AnnoncesResponses, Error> = Result<AnnoncesResponses, Error>.failure(FakeApiData().error)
    
    func fetchCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        completion(categoriesResult)
    }
    
    func fetchAnnonces(completion: @escaping (Result<AnnoncesResponses, Error>) -> Void) {
        completion(annoncesResult)
    }
            
}
