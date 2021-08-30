//
//  RepositoryInteractor.swift
//  TrendingProjects
//
//  Created by Elene_Akhvlediani on 7/8/21.
//

import Foundation

protocol RepositoryInteractorBusinessLogic {
    func loadData()
    func openRepository()
    func openUser()
}

final class RepositoryInteractor: RepositoryInteractorBusinessLogic {

    var presenter: RepositoryPresentationLogic?
    var router: RepositoryRoutingLogic?

    private let repository: RepositoryRepresentation
    
    init(repository: RepositoryRepresentation) {
        self.repository = repository
    }

    func loadData() {
        presenter?.presentRepository(representation: repository)
    }

    func openRepository() {
        guard let urlString = repository.url, let url = URL(string: urlString) else {
            presenter?.presentError()
            return
        }
        router?.navigateToUser(with: url)
    }

    func openUser() {
        guard let url = URL(string: "https://github.com/\(repository.author)") else {
            presenter?.presentError()
            return
        }
        router?.navigateToUser(with: url)
    }
}
