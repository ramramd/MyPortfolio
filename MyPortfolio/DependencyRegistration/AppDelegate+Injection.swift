//
//  AppDelegate+Injection.swift
//  MyPortfolio
//
//  Created by Naveen Ramachandrappa on 4/25/23.
//

import Foundation
import Resolver

//Register dependecnies
extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        registerViewModels()
        registerApiRequests()
    }

    //Regsiter all view models here
    public static func registerViewModels() {
        register { PortFolioViewModel() }
    }

    //Register all Api Requests here
    public static func registerApiRequests() {
        register(name: .getPortfolioApiRequest) { (_, _) -> ApiRequestProtocol in
            return GetPortfolioApiRequest()
        }
    }
}
