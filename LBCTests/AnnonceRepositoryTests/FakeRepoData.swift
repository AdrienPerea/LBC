//
//  FakeResponseData.swift
//  LBCTests
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

class FakeRepoData {

    var annoncesCorrectData: Data {
        let bundle = Bundle(for: FakeRepoData.self)
        let url = bundle.url(forResource: "annonces", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    var categoriesCorrectData: Data {
        let bundle = Bundle(for: FakeRepoData.self)
        let url = bundle.url(forResource: "categories", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    let incorrectData = "erreur".data(using: .utf8)!


}
