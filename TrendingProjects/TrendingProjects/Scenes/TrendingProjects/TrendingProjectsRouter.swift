//
//  TrendingProjectsRouter.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import UIKit

protocol TrendingProjectsRoutingLogic {
    func navigate(to repository: RepositoryRepresentation)
}

final class TrendingProjectsRouter: TrendingProjectsRoutingLogic {
    weak var viewController: TrendingProjectsViewController?

    func navigate(to repository: RepositoryRepresentation) {
        let vc = RepositoryConfigurator.configuredViewController(repository: repository)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

}
