//
//  RepositoryPresenter.swift
//  TrendingProjects
//
//  Created by Elene_Akhvlediani on 7/8/21.
//

import Foundation

protocol RepositoryPresentationLogic {
    func presentRepository(representation: RepositoryRepresentation)
    func presentError()
}

final class RepositoryPresenter: RepositoryPresentationLogic {

    struct Const {
        static let writtenIn = "Written in:"
        static let openRepository = "Open Repository"
        static let stars = "Stars"
        static let forks = "Forks"
        static let errorTitle = "Unable to present data"
        static let ok = "OK"
    }

    weak var viewController: RepositoryDisplayLogic?

    func presentRepository(representation: RepositoryRepresentation) {
        let repositoryViewModel = Repository.ViewModel(title: representation.name,
                                                       description: representation.description,
                                                       starsTitle: "\(Const.stars) \(representation.stars)",
                                                       forksTitle: "\(Const.forks) \(representation.forks)",
                                                       userName: representation.author,
                                                       userAvatarURL: representation.avatar,
                                                       language: Repository.ViewModel.Language(title: Const.writtenIn, value: representation.language, color: representation.languageTextColor ?? .secondaryLabel),
                                                       openRepositoryButtonTitle: Const.openRepository)
        viewController?.displayData(repository: repositoryViewModel)
    }

    func presentError() {
        viewController?.displayError(viewModel: Repository.ErrorViewModel(title: Const.errorTitle, buttonTitle: Const.ok))
    }

}
