//
//  FakeResponseData.swift
//  LBCTests
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

class FakeResponseData {

    let reponseOK = HTTPURLResponse(url: URL(string: "http://leboncoin.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

    let reponseKO = HTTPURLResponse(url: URL(string: "http://leboncoin.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class AnnonceAPIError: Error {}
    let error = AnnonceAPIError()

    var annoncesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "annonces", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    var categoriesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "categories", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    let changeIncorrectData = "erreur".data(using: .utf8)!

}

