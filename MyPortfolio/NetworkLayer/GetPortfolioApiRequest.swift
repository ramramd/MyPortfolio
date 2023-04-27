//
//  GetPortfolioApiRequest.swift
//  MyStocks
//
//  Created by Naveen Ramachandrappa on 4/24/23.
//

import Foundation

//Api Requests completely define the request like which end point to hit and what is the http type
class GetPortfolioApiRequest: ApiRequestProtocol {
    
    //Change this endpointPath to "/getMalFormedPortfolioData" for malformed response
    //Change this endpointPath to "/getEmptyPortfolio" for empty response
    //Change this endpointPath to "/getStocks" for full stocks data
    var endpointPath = "/getStocks"
    //We usually get this base end point via a start up call. In this project, I am just hardcoding it.
    var endpointBase = "https://demo7701654.mockable.io"

    func executeRequest<T>(completionBlock: @escaping (T?) -> Void) where T: Decodable {
        guard let url = URL(string: endpoint) else {
            completionBlock(nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        executeRequestAsync(urlRequest: request) { (response) in
            completionBlock(response)
        }
    }
}
