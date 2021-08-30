//
//  RepositoryRouter.swift
//  TrendingProjects
//
//  Created by Elene_Akhvlediani on 7/10/21.
//

import Foundation
protocol RepositoryRoutingLogic {
    func navigateToRepository(with url: URL)
    func navigateToUser(with url: URL)
}

final class RepositoryRouter: RepositoryRoutingLogic {

    weak var viewController: RepositoryViewController?

    func navigateToUser(with url: URL) {
        viewController?.open(url: url)
    }

    func navigateToRepository(with url: URL) {
        viewController?.open(url: url)
    }
}
