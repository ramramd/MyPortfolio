//
//  ViewController.swift
//  MyPortfolio
//
//  Created by Naveen Ramachandrappa on 4/25/23.
//

import UIKit
import Resolver
import RxSwift

class ViewController: BaseViewController {

    @IBOutlet weak var portfolioEmptyLabel: UILabel!
    @IBOutlet weak var serverErrorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "stockCell"
    @Injected var viewModel: PortFolioViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Portfolio"
        tableView.register(UINib(nibName: "StockTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        applyBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getStocks()
    }
    
    func applyBinding() {
        
        viewModel.noData.map(!)
            .bind(to: portfolioEmptyLabel.rx.isHidden)
        .disposed(by: self.disposeBag)
        
        viewModel.isDataLoading.map(!)
            .bind(to: loadingIndicator.rx.isHidden)
        .disposed(by: self.disposeBag)
        
        viewModel.isServerError.map(!)
            .bind(to: serverErrorLabel.rx.isHidden)
        .disposed(by: self.disposeBag)
    
        //Binding to populate tableview when the list of stocks is fetched from server
        viewModel.stocksList
            .bind(to: tableView.rx.items(cellIdentifier: cellReuseIdentifier, cellType: StockTableViewCell.self)) {
                (index, stock: Stock, cell: StockTableViewCell) in
                cell.tickerLabel.text = stock.name
                cell.priceLabel.text = String(stock.currentPriceCents)
                cell.priceLabel.text = self.viewModel.appendCurrencyUnit(currency: stock.currency, price: stock.currentPriceCents)
                cell.unitsLabel.text = String(stock.quantity ?? 0)
                cell.unitsLabel.text = "\(stock.quantity ?? 0) shares"
            }
            .disposed(by: disposeBag)
    }



}

