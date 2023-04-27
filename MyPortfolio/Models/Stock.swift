//
//  Stock.swift
//  MyStocks
//
//  Created by Naveen Ramachandrappa on 4/24/23.
//

import Foundation

// MARK: - StockList
struct StockList: Codable {
    let stocks: [Stock]
}

// MARK: - Stock
struct Stock: Codable {
    let ticker, name: String
    let currency: Currency
    let currentPriceCents: Int
    let quantity: Int?
    let currentPriceTimestamp: Int

    enum CodingKeys: String, CodingKey {
        case ticker, name, currency
        case currentPriceCents = "current_price_cents"
        case quantity
        case currentPriceTimestamp = "current_price_timestamp"
    }
}

enum Currency: String, Codable {
    case usd = "USD"
}

typealias Stocks = [Stock]

