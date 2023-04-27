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
    var stocksList = BehaviorRelay<[Stock]>(value: [])
    
    //Inject dependecies with Resolver dependency injection framework
    @Injected(name: .getStocksApiRequest) var getStocksApiRequest: ApiRequestProtocol
    
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
            let processedStockData = self?.processStockData(rawStockData: response)
            self?.stocksList.accept(response.stocks)
            self?.noData.accept(false)
            self?.isDataLoading.accept(false)
        }
    }
    
    func getStockList(completionBlock: @escaping (StockList?) -> Void) {
        isDataLoading.accept(true)
        getStocksApiRequest.executeRequest { (response) in
          completionBlock(response)
        }
    }
    
    func processStockData(rawStockData: StockList) -> [StockModel] {
        let processStockData = [StockModel]()
        for item in rawStockData.stocks {
            var stockData = StockModel()
            stockData.name = item.name
            stockData.currentPrice = appendCurrencyUnit(currency: item.currency, price: item.currentPriceCents)
            stockData.quantity = item.quantity
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
