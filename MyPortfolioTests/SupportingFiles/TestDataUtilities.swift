//
//  TestDataUtilities.swift
//  MyPortfolioTests
//
//  Created by Naveen Ramachandrappa on 4/27/23.
//

import Foundation

class TestDataUtilities {

    static let stockDataFile = "stockdata"
    static let noStockDataFile = "nostockdata"
    static let stockBadDataFile = "stockbaddata"

    static func readJSONFromFile<T: Decodable>(fileName: String) -> T? {
        var json: T?
        if let path = Bundle(for: self).path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONDecoder().decode(T.self, from: data)
            } catch {
                // Handle error
            }
        }
        return json
    }

//    static func readJSONDictionaryFromFile(fileName: String) -> Any? {
//        var jsonString: Any?
//        if let path = Bundle(for: self).path(forResource: fileName, ofType: "json") {
//            do {
//                let fileUrl = URL(fileURLWithPath: path)
//                // Getting data from JSON file using the file URL
//                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
//                jsonString = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])
//            } catch {
//                // Handle error
//            }
//        }
//        return jsonString
//    }
}

