//
//  MainViewController.swift
//  TrendingProjects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import UIKit
import SafariServices

final class MainViewController: UIViewController {
    private let animationDuration = 0.3

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var enterTheAppButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateImageView()
    }

    private func animateImageView() {
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: {
                            self.iconImageView.transform = .identity.scaledBy(x: 1.1, y: 1.1)
                       },
                       completion: { [weak self] _ in
                            guard let self = self else { return }
                        UIView.animate(withDuration: self.animationDuration) {
                                self.iconImageView.transform = .identity
                            }
                       })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        enterTheAppButton.layer.cornerRadius = enterTheAppButton.frame.height / 2
    }

    @IBAction private func enterTheAppAction(_ sender: UIButton) {
        let trendingProjectsViewController = TrendingProjectsConfigurator.configuredViewController()
        navigationController?.pushViewController(trendingProjectsViewController, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction private func goToGithubAction(_ sender: UIButton) {
        open(urlString: "https://www.github.com/")
    }

    @IBAction private func privacyPolicyAction(_ sender: UIButton) {
        open(urlString: "https://docs.github.com/en/github/site-policy/github-privacy-statement")
    }

    @IBAction private func termsOfUseAction(_ sender: UIButton) {
        open(urlString: "https://docs.github.com/en/github/site-policy/github-terms-of-service")
    }
    
    private func open(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        open(url: url)
    }
}

