//
//  RepositoryViewController.swift
//  TrendingProjects
//
//  Created by Elene_Akhvlediani on 7/8/21.
//

import UIKit

protocol RepositoryDisplayLogic:  AnyObject {
    func displayData(repository: Repository.ViewModel)
    func displayError(viewModel: Repository.ErrorViewModel)
}

final class RepositoryViewController: UIViewController, RepositoryDisplayLogic {

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userNameButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var languageValueLabel: UILabel!
    @IBOutlet private weak var languageTitleLabel: UILabel!
    @IBOutlet private weak var openRepositoryButton: UIButton!
    var interactor: RepositoryInteractorBusinessLogic?

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
    }

    func displayData(repository: Repository.ViewModel) {
        title = repository.title
        userNameButton.setTitle(repository.userName, for: .normal)
        titleLabel.text = repository.title
        descriptionLabel.text = repository.description
        starsLabel.text = repository.starsTitle
        forksLabel.text = repository.forksTitle
        if let avatarURL = repository.userAvatarURL {
            userImageView.lazyLoad(url: avatarURL) { [weak self] img in
                guard let self = self else { return }
                UIView.transition(with: self.userImageView,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: { self.userImageView.image = img },
                                  completion: nil)
            }
        }
        languageTitleLabel.text = repository.language.title
        languageValueLabel.text = repository.language.value
        languageValueLabel.textColor = repository.language.color
    }

    @IBAction private func openRepositoryClicked() {
        interactor?.openRepository()
    }

    @IBAction private func userNameClicked() {
        interactor?.openUser()
    }

    func displayError(viewModel: Repository.ErrorViewModel) {
        displayAlert(title: viewModel.title, message: nil, buttonActions: [UIAlertAction(title: viewModel.buttonTitle, style: .default, handler: nil)])
    }
}
