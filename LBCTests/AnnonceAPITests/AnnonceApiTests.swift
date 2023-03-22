//
//  AnnonceApiTests.swift
//  LBCTests
//
//  Created by Adrien PEREA on 22/03/2023.
//

import XCTest
@testable import LBC

final class AnnonceApiTests: XCTestCase {

    // MARK: - TEST Categories

    func test_fetchCategories_withData_withoutError() {
        //given
        let jsonData = FakeApiData().data

        let networkEngine = NetworkEngineMock(data: jsonData)

        let expectation = XCTestExpectation(description: "changing queue")

        let annonceApi = AnnonceAPI(engine: networkEngine)

        annonceApi.fetchCategories(completion: { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(_):
                XCTFail("test success")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }

    func test_fetchAnnonces_withData_withoutError() {
        //given
        let jsonData = FakeApiData().data

        let networkEngine = NetworkEngineMock(data: jsonData)

        let expectation = XCTestExpectation(description: "changing queue")

        let annonceApi = AnnonceAPI(engine: networkEngine)

        annonceApi.fetchAnnonces(completion: { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(_):
                XCTFail("test success")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }

    func test_fetchCategories_withData_withError() {
        //given
        let jsonData = FakeApiData().data
        let error: Error = FakeApiData().error

        let networkEngine = NetworkEngineMock(data: jsonData, error: error)

        let expectation = XCTestExpectation(description: "changing queue")

        let annonceApi = AnnonceAPI(engine: networkEngine)

        annonceApi.fetchCategories(completion: { result in
            switch result {
            case .success(_):
                XCTFail("test fail")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }

    func test_fetchAnnonces_withData_withError() {
        //given
        let jsonData = FakeApiData().data
        let error: Error = FakeApiData().error

        let networkEngine = NetworkEngineMock(data: jsonData, error: error)

        let expectation = XCTestExpectation(description: "changing queue")

        let annonceApi = AnnonceAPI(engine: networkEngine)

        annonceApi.fetchAnnonces(completion: { result in
            switch result {
            case .success(_):
                XCTFail("test fail")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }

    func test_fetchCategories_withoutData_withError() {
        //given
        let error: Error = FakeApiData().error

        let networkEngine = NetworkEngineMock(error: error)

        let expectation = XCTestExpectation(description: "changing queue")

        let annonceApi = AnnonceAPI(engine: networkEngine)

        annonceApi.fetchCategories(completion: { result in
            switch result {
            case .success(_):
                XCTFail("test fail")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }

    func test_fetchAnnonces_withoutData_withError() {
        //given
        let error: Error = FakeApiData().error

        let networkEngine = NetworkEngineMock(error: error)

        let expectation = XCTestExpectation(description: "changing queue")

        let annonceApi = AnnonceAPI(engine: networkEngine)

        annonceApi.fetchAnnonces(completion: { result in
            switch result {
            case .success(_):
                XCTFail("test fail")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }

    func test_fetchCategories_withoutData_withoutError() {
        //given
        let networkEngine = NetworkEngineMock()

        let expectation = XCTestExpectation(description: "changing queue")

        let annonceApi = AnnonceAPI(engine: networkEngine)

        annonceApi.fetchCategories(completion: { result in
            switch result {
            case .success(_):
                XCTFail("test fail")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }

    func test_fetchAnnonces_withoutData_withoutError() {
        //given
        let networkEngine = NetworkEngineMock()
        let expectation = XCTestExpectation(description: "changing queue")
        let annonceApi = AnnonceAPI(engine: networkEngine)

        annonceApi.fetchAnnonces(completion: { result in
            switch result {
            case .success(_):
                XCTFail("test fail")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
}

// MARK: - URLProtocol Mock
class NetworkEngineMock: NetworkEngine {
    typealias Handler = NetworkEngine.Handler

    init(data: Data? = nil, error: Error? = nil) {
        self.data = data
        self.error = error
    }

    let data: Data?
    let error: Error?

    func performRequest(for url: URL, completionHandler: @escaping Handler) {
        completionHandler(data, nil, error)
    }
}
