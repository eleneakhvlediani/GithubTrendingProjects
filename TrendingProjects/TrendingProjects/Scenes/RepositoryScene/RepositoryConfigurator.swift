//
//  RepositoryConfigurator.swift
//  TrendingProjects
//
//  Created by Elene_Akhvlediani on 7/8/21.
//

import Foundation

final class RepositoryConfigurator {
    static func configuredViewController(repository: RepositoryRepresentation) -> RepositoryViewController {

        let viewController = RepositoryViewController.instantiateFromNib()

        let router = RepositoryRouter()
        router.viewController = viewController
        
        let presenter = RepositoryPresenter()
        presenter.viewController = viewController

        let interactor = RepositoryInteractor(repository: repository)
        interactor.presenter = presenter
        interactor.router = router

        viewController.interactor = interactor

        return viewController
    }
}
