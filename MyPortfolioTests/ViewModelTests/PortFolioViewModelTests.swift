//
//  PortFolioViewModelTests.swift
//  MyPortfolioTests
//
//  Created by Naveen Ramachandrappa on 4/26/23.
//

import Foundation
import Resolver
import XCTest
@testable import MyPortfolio


class PortFolioViewModelTests: XCTestCase {
    
    var subject: PortFolioViewModel!
    
    override func setUp() {
        super.setUp()
        subject = PortFolioViewModel()
        subject.getPortfolioApiRequest = GetPortfolioApiRequestMock()
    }
    
    override func tearDown() {
        subject = nil
    }
    
    func testCallingGetStocksListCallsExecuteRequest() {
        subject.isDataLoading.accept(false)
        subject.getStockList(completionBlock:  { _ in })
        XCTAssertTrue((subject.getPortfolioApiRequest as? GetPortfolioApiRequestMock)?.executeRequestCalled ?? false)
        XCTAssertTrue(subject.isDataLoading.value)
    }
    
    func testCallingAppendCurrencyUnitFormatsAndAppendsCurrency() {
        let value = subject.appendCurrencyUnit(currency: .usd, price: 45236)
        XCTAssertTrue(value.hasPrefix("$"))
        XCTAssertTrue(value == "$452.36")
    }
    
    func testCallingGetStocksUpdatesViewModelProperties() {
        XCTAssertTrue(subject.stocksList.value.count == 0)
        subject.noData.accept(true)
        subject.isDataLoading.accept(true)
        (subject.getPortfolioApiRequest as? GetPortfolioApiRequestMock)?.response = TestDataUtilities.readJSONFromFile(fileName: TestDataUtilities.stockDataFile)
        subject.getStocks()
        XCTAssertTrue(subject.stocksList.value.count == 3)
        XCTAssertFalse(subject.noData.value)
        XCTAssertFalse(subject.isDataLoading.value)
    }
    
    func testCallingGetStocksSetsServerErrorWhenResponseIsNil() {
        subject.isServerError.accept(false)
        subject.isDataLoading.accept(true)
        (subject.getPortfolioApiRequest as? GetPortfolioApiRequestMock)?.response = TestDataUtilities.readJSONFromFile(fileName: TestDataUtilities.stockBadDataFile)
        subject.getStocks()
        XCTAssertTrue(subject.isServerError.value)
        XCTAssertFalse(subject.isDataLoading.value)
    }
    
    func testCallingGetStocksSetsNoDataWhenPortfolioIsEmpty() {
        subject.noData.accept(false)
        subject.isDataLoading.accept(true)
        (subject.getPortfolioApiRequest as? GetPortfolioApiRequestMock)?.response = TestDataUtilities.readJSONFromFile(fileName: TestDataUtilities.noStockDataFile)
        subject.getStocks()
        XCTAssertTrue(subject.noData.value)
        XCTAssertFalse(subject.isDataLoading.value)
    }
    
    func testCallingProcessStockDataReturnsProcessedStockData() {
        let stockList:StockList! = TestDataUtilities.readJSONFromFile(fileName: TestDataUtilities.stockDataFile)
        let processedData = subject.processStockData(rawStockData: stockList)
        XCTAssertTrue(processedData.count == 3)
        XCTAssertNotNil(processedData[0].name)
        XCTAssertNotNil(processedData[0].currentPrice)
        XCTAssertNotNil(processedData[0].quantity)
    }
    
    func testCallingFormatStockQuantityReturnsZeroShareswhenQuantityIsNil() {
        XCTAssertTrue(subject.formatStockQuantity(quantity: nil) == "0 shares")
    }
    
    func testCallingFormatStockQuantityReturnsFormattedStockQuantityWhenQuantityIsONE() {
        XCTAssertTrue(subject.formatStockQuantity(quantity: 1) == "1 share")
    }
    
    func testCallingFormatStockQuantityReturnsFormattedStockQuantityWhenQuantityIsMoreThanONE() {
        XCTAssertTrue(subject.formatStockQuantity(quantity: 2) == "2 shares")
    }

}
