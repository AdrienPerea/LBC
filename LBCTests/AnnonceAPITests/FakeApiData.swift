//
//  FakeResponseData.swift
//  LBCTests
//
//  Created by Adrien PEREA on 22/03/2023.
//

import Foundation

class FakeApiData {

    let reponseOK = HTTPURLResponse(url: URL(string: "http://leboncoin.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

    let reponseKO = HTTPURLResponse(url: URL(string: "http://leboncoin.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class AnnonceAPIError: Error {}
    let error = AnnonceAPIError()

    let data = "datas".data(using: .utf8)!

}
