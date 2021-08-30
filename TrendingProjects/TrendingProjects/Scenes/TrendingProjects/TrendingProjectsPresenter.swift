//
//  TrendingProjectsPresenter.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation

protocol TrendingProjectsPresentationLogic {
    func presentData(response: TrendingProjects.Data.Response)
    func presentError(retryAction: @escaping () -> Void)
    func presentLoader()
    func presentInitialData()
}

final class TrendingProjectsPresenter: TrendingProjectsPresentationLogic {
    struct Const {
        static let title = "Github Trending Projects"
        static let createdBy = "Created by:"
        static let writtenIn = "Written in:"
        struct Error {
            static let text = "Unable to fetch data"
            static let buttonTitle = "Unable to fetch data"
        }
    }
    weak var viewController: TrendingProjectsDisplayLogic?
    func presentData(response: TrendingProjects.Data.Response) {
        let repositoryCellViewModels = response.repositories.map { TrendingProjects.Data.RepositoryCellViewModel(title: $0.name, createdBy: "\(Const.createdBy) \($0.author)", description: $0.description, writtenIn: "\(Const.writtenIn) \($0.language)", color: $0.languageTextColor)}
        viewController?.displayData(viewModel: TrendingProjects.Data.ViewModel(repositoryCellViewModels: repositoryCellViewModels, isSearchVisible: !repositoryCellViewModels.isEmpty || !response.searchPhraseIsEmpty))
    }

    func presentError(retryAction: @escaping () -> Void) {
        let errorViewModel = TrendingProjects.Data.ErrorViewModel(title: Const.Error.text, buttonTitle: Const.Error.buttonTitle, action: retryAction)
        viewController?.displayError(viewModel: errorViewModel)
    }

    func presentLoader() {
        viewController?.displayLoader()
    }

    func presentInitialData() {
        viewController?.displayTitle(title: Const.title)
    }
}
