//
//  GetPortfolioApiRequestMock.swift
//  MyPortfolioTests
//
//  Created by Naveen Ramachandrappa on 4/26/23.
//

import Foundation
@testable import MyPortfolio


class GetPortfolioApiRequestMock: ApiRequestProtocol {
    var endpointPath: String = ""
    var endpointBase: String = ""
    var executeRequestCalled = false
    var response: StockList?

    func executeRequest<T>(completionBlock: @escaping (T?) -> Void) where T: Decodable {
        executeRequestCalled = true
        completionBlock(response as? T)
    }
}
