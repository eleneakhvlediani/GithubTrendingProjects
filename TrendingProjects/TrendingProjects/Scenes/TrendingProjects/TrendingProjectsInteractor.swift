//
//  TrendingProjectsInteractor.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation

protocol TrendingProjectsInteractorBusinessLogic {
    func loadData()
    func reloadData()
    func loadInitialData()
    func openRepository(at index: Int)
    func filterRepositories(by text: String)
}

final class TrendingProjectsInteractor: TrendingProjectsInteractorBusinessLogic {

    var presenter: TrendingProjectsPresentationLogic?
    var router: TrendingProjectsRoutingLogic?
    private var throttler = Throttler(seconds: 0.2)

    private var repositories: [RepositoryRepresentation] = [] {
        didSet {
            filterRepositories()
        }
    }
    private var currentSearchPhrase = "" {
        didSet {
            filterRepositories()
        }
    }

    private let apiClient: TrendingProjectsAPIClient

    init(apiClient: TrendingProjectsAPIClient = TrendingProjectsAPIClient()) {
        self.apiClient = apiClient
    }

    func loadInitialData() {
        presenter?.presentInitialData()
    }

    func loadData() {
        presenter?.presentLoader()
        fetchRepositories()
    }

    private var filteredRepositories: [RepositoryRepresentation] = []

    private func filterRepositories() {
        guard !currentSearchPhrase.isEmpty else {
            filteredRepositories = repositories
            return
        }
        filteredRepositories = repositories.filter {
            $0.name.localizedCaseInsensitiveContains(currentSearchPhrase) ||
            $0.description.localizedCaseInsensitiveContains(currentSearchPhrase) ||
            $0.author.localizedCaseInsensitiveContains(currentSearchPhrase) ||
            $0.language.localizedCaseInsensitiveContains(currentSearchPhrase) }
    }

    private func fetchRepositories() {
        apiClient.getTrendingProjects { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                self?.presentData()
            case .failure(let error):
                print(error)
                self?.presenter?.presentError(retryAction: {
                    self?.loadData()
                })
            }
        }
    }

    private func presentData() {
        presenter?.presentData(response: TrendingProjects.Data.Response(repositories: filteredRepositories, searchPhraseIsEmpty: currentSearchPhrase.isEmpty))
    }

    func reloadData() {
        fetchRepositories()
    }

    func openRepository(at index: Int) {
        router?.navigate(to: filteredRepositories[index])
    }

    func filterRepositories(by searchPhrase: String) {
        guard searchPhrase != currentSearchPhrase else { return }
        throttler.throttle {
            DispatchQueue.main.async { [weak self] in
                self?.currentSearchPhrase = searchPhrase
                self?.presentData()
            }
        }
    }

}
