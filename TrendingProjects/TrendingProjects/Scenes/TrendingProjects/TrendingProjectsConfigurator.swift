//
//  TrendingProjectsConfigurator.swift
//  Trending projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation


final class TrendingProjectsConfigurator {

    // MARK: - Configuration

    static func configuredViewController() -> TrendingProjectsViewController {

        let viewController = TrendingProjectsViewController()

        let router = TrendingProjectsRouter()
        router.viewController = viewController

        let presenter = TrendingProjectsPresenter()
        presenter.viewController = viewController

        let interactor = TrendingProjectsInteractor()
        interactor.presenter = presenter
        interactor.router = router

        viewController.interactor = interactor

        return viewController
    }
}
