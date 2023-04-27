//
//  ApiRequestProtocol.swift
//  MyStocks
//
//  Created by Naveen Ramachandrappa on 4/24/23.
//

import Foundation

//All ApiRequest classes should conform to this protocol
protocol ApiRequestProtocol {
    var endpointPath: String { get set }
    var endpointBase: String { get set }
    func executeRequest<T: Decodable>(completionBlock: @escaping (T?) -> Void)
}

extension ApiRequestProtocol {
    
    var endpoint: String { return endpointBase + endpointPath }
    
    //Using generics here so that the T type is based on the expected response type
    func executeRequestAsync<T: Decodable>(urlRequest: URLRequest?, completionBlock: @escaping (T?) -> Void) {

        guard let urlRequest else {
            completionBlock(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                //Return nil if data is nil
                completionBlock(nil)
                return
            }
            do {
                let deserializedData = try JSONDecoder().decode(T.self, from: data)
                completionBlock(deserializedData)
            } catch {
                //Return nil if deserialization fails
                completionBlock(nil)
                return
            }
        }
        task.resume()
    }
    
}
