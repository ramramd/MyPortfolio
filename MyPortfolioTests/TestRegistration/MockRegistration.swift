//
//  MockRegistration.swift
//  MyPortfolioTests
//
//  Created by Naveen Ramachandrappa on 4/26/23.
//

import Foundation
import Resolver
@testable import MyPortfolio

extension Resolver {

    static var mock = Resolver(child: main)

    public static func registerMocks() {
        defaultScope = .application
        ResolverScopeCache.application.reset()
        mock.register(name: .getPortfolioApiRequest) { GetPortfolioApiRequestMock() as ApiRequestProtocol
        }
        root = mock
    }
}
