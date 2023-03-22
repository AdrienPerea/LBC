//
//  AnnonceApiTests.swift
//  LBCTests
//
//  Created by Adrien PEREA on 22/03/2023.
//

import XCTest
@testable import LBC

final class AnnonceApiTests: XCTestCase {

    // MARK: - TEST GetChange

    func testGetChangeGivenDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().annoncesCorrectData

        AnnonceURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [AnnonceURLProtocol.self]

        let annonceApi = AnnonceAPI(urlSession: URLSession(configuration: configuration))

        annonceApi.fetchCategories(completion: { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }


}

// MARK: - Fake URLProtocol
final class AnnonceURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    static var loadingHandler: ((URLRequest) -> (Data?, HTTPURLResponse, Error?))?

    override func startLoading() {
        guard let handler = AnnonceURLProtocol.loadingHandler else {
            XCTFail("Loading handler is not set.")
            return
        }
        let (data, response, error) = handler(request)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            client?.urlProtocol(self, didFailWithError: error!)
        }
    }

    override func stopLoading() {}
}

