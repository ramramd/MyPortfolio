//
//  BaseViewModel.swift
//  MyStocks
//
//  Created by Naveen Ramachandrappa on 4/24/23.
//

import Foundation
import RxCocoa

class BaseViewModel {
    var noData = BehaviorRelay<Bool>(value: false)
    var isDataLoading = BehaviorRelay<Bool>(value: true)
    var isServerError = BehaviorRelay<Bool>(value: false)
}
