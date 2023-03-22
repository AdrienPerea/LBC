//
//  AnnonceRepositoryTests.swift
//  LBCTests
//
//  Created by Adrien PEREA on 22/03/2023.
//

import XCTest
@testable import LBC

final class AnnonceRepositoryTests: XCTestCase {

    // MARK: - TEST Categories

    func test_fetchCategories_withError() {
        //given
        let error: Error = FakeApiData().error

        let expectation = XCTestExpectation(description: "changing queue")
        let result = Result<Data, Error>.failure(error)

        let annonceRepo = AnnonceRepository.shared
        annonceRepo.annonceAPI = AnnonceApiMock(result: result)

        annonceRepo.fetchCategories { result in
            switch result {
            case .success(_):
                XCTFail("failure test")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func test_fetchCategories_withGoodData() {
        //given
        let datas: Data = FakeRepoData().categoriesCorrectData

        let expectation = XCTestExpectation(description: "changing queue")
        let result = Result<Data, Error>.success(datas)

        let annonceRepo = AnnonceRepository.shared
        annonceRepo.annonceAPI = AnnonceApiMock(result: result)

        annonceRepo.fetchCategories { result in
            switch result {
            case .success(let categories):
                XCTAssertNotNil(categories)
            case .failure(_):
                XCTFail("success test")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func test_fetchCategories_withBadData() {
        //given
        let datas: Data = FakeRepoData().incorrectData

        let expectation = XCTestExpectation(description: "changing queue")
        let result = Result<Data, Error>.success(datas)

        let annonceRepo = AnnonceRepository.shared
        annonceRepo.annonceAPI = AnnonceApiMock(result: result)

        annonceRepo.fetchCategories { result in
            switch result {
            case .success(_):
                XCTFail("fail test")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    // MARK: - TEST Annonces

    func test_fetchAnnonces_withError() {
        //given
        let error: Error = FakeApiData().error

        let expectation = XCTestExpectation(description: "changing queue")
        let result = Result<Data, Error>.failure(error)

        let annonceRepo = AnnonceRepository.shared
        annonceRepo.annonceAPI = AnnonceApiMock(result: result)
        
        annonceRepo.fetchAnnonces { result in
            switch result {
            case .success(_):
                XCTFail("failure test")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func test_fetchAnnonces_withGoodData() {
        //given
        let datas: Data = FakeRepoData().annoncesCorrectData

        let expectation = XCTestExpectation(description: "changing queue")
        let result = Result<Data, Error>.success(datas)

        let annonceRepo = AnnonceRepository.shared
        annonceRepo.annonceAPI = AnnonceApiMock(result: result)

        annonceRepo.fetchAnnonces { result in
            switch result {
            case .success(let annonces):
                XCTAssertNotNil(annonces)
            case .failure(_):
                XCTFail("success test")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func test_fetchAnnonces_withBadData() {
        //given
        let datas: Data = FakeRepoData().incorrectData

        let expectation = XCTestExpectation(description: "changing queue")
        let result = Result<Data, Error>.success(datas)

        let annonceRepo = AnnonceRepository.shared
        annonceRepo.annonceAPI = AnnonceApiMock(result: result)

        annonceRepo.fetchAnnonces { result in
            switch result {
            case .success(_):
                XCTFail("fail test")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}

// MARK: - AnnonceApi Mock

final class AnnonceApiMock: AnnonceApiProtocol {

    init(result: Result<Data, Error>) {
        self.result = result
    }

    let result: Result<Data, Error>

    func fetchCategories(completion: @escaping (Result<Data, Error>) -> Void) {
        completion(result)
    }

    func fetchAnnonces(completion: @escaping (Result<Data, Error>) -> Void) {
        completion(result)
    }

}
