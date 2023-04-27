//
//  PortFolioViewModel.swift
//  MyPortfolio
//
//  Created by Naveen Ramachandrappa on 4/25/23.
//

import Foundation
import RxSwift
import Resolver
import RxCocoa

class PortFolioViewModel:BaseViewModel {
    //View model properties
    var stocksList = BehaviorRelay<[StockModel]>(value: [])
    
    //Inject dependecies with Resolver dependency injection framework
    @Injected(name: .getPortfolioApiRequest) var getPortfolioApiRequest: ApiRequestProtocol
    
    func getStocks()  {
        getStockList { [ weak self] response in
            guard let response = response else {
                self?.isServerError.accept(true)
                self?.isDataLoading.accept(false)
                return
            }
            
            guard !response.stocks.isEmpty else {
                self?.noData.accept(true)
                self?.isDataLoading.accept(false)
                return
            }
            if let processedStockData = self?.processStockData(rawStockData: response) {
                self?.stocksList.accept(processedStockData)
            }
            self?.noData.accept(false)
            self?.isDataLoading.accept(false)
        }
    }
    
    func getStockList(completionBlock: @escaping (StockList?) -> Void) {
        isDataLoading.accept(true)
        getPortfolioApiRequest.executeRequest { (response) in
          completionBlock(response)
        }
    }
    
    func processStockData(rawStockData: StockList) -> [StockModel] {
        var processStockData = [StockModel]()
        for item in rawStockData.stocks {
            var stockData = StockModel()
            stockData.name = item.name
            stockData.currentPrice = appendCurrencyUnit(currency: item.currency, price: item.currentPriceCents)
            stockData.quantity = item.quantity
            processStockData.append(stockData)
        }
        return processStockData
    }
    
    func appendCurrencyUnit(currency: Currency, price: Int) -> String {
        if currency == .usd  {
            return "$\(Float(price)/100.0)"
        }
        return "\(price)"
    }
}
