//
//  TrendingProjectsViewController.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import UIKit

protocol TrendingProjectsDisplayLogic: AnyObject {
    func displayTitle(title: String)
    func displayData(viewModel: TrendingProjects.Data.ViewModel)
    func displayLoader()
    func displayError(viewModel: TrendingProjects.Data.ErrorViewModel)
}

final class TrendingProjectsViewController: UIViewController, TrendingProjectsDisplayLogic {

    private var tableView: UITableView!
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator  = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return activityIndicator
    }()

    private lazy var errorView: ErrorView? = {
        guard let errorView = ErrorView.loadFromNib() else { return nil }
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)
        errorView.pinEdges(to: view)
        return errorView
    }()

    var interactor: TrendingProjectsInteractorBusinessLogic?

    private var viewModel: TrendingProjects.Data.ViewModel? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        configureSearch()
        interactor?.loadInitialData()
        interactor?.loadData()
    }

    private func configureSearch() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func configureTableView() {
        tableView = .install(in: view, with: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        tableView.tableFooterView = UIView()
        tableView.registerNib(cell: RepositoryTableViewCell.self)
    }

    func displayData(viewModel: TrendingProjects.Data.ViewModel) {
        self.viewModel = viewModel
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        navigationItem.searchController = viewModel.isSearchVisible ? searchController : nil
        errorView?.isHidden = true
        refreshControl.endRefreshing()
    }

    func displayLoader() {
        tableView.isHidden = true
        navigationItem.searchController = nil
        errorView?.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func displayError(viewModel: TrendingProjects.Data.ErrorViewModel) {
        tableView.isHidden = true
        navigationItem.searchController = nil
        errorView?.showWithAnimation()
        errorView?.update(with: viewModel)
        activityIndicator.stopAnimating()
    }

    func displayTitle(title: String) {
        navigationItem.title = title
        searchController.searchBar.placeholder = NSLocalizedString("Filter repositories by name", comment: "")
    }

    @objc func refresh(_ sender: AnyObject) {
        interactor?.reloadData()
    }
}

extension TrendingProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel?.repositoryCellViewModels.count ?? 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { fatalError() }
        let cell: RepositoryTableViewCell = tableView.dequeueReusableCell(for: RepositoryTableViewCell.self, for: indexPath)
        cell.update(with: viewModel.repositoryCellViewModels[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.openRepository(at: indexPath.row)
    }
}

extension TrendingProjectsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        interactor?.filterRepositories(by: searchController.searchBar.text ?? "")
    }
}
