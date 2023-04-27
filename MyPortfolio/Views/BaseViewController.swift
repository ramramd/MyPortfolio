//
//  BaseViewController.swift
//  MyStocks
//
//  Created by Naveen Ramachandrappa on 4/24/23.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    func displayError() {
        let alert = UIAlertController(title: "Alert", message: "An error occured. Please try again later", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
