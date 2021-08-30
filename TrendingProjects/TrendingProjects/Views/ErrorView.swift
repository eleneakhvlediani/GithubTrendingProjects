//
//  ErrorView.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import UIKit

final class ErrorView: UIView {

    private var viewModel: TrendingProjects.Data.ErrorViewModel?
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var retryButton: UIButton!

    @IBAction private func retryButtonClicked(_ sender: UIButton) {
        viewModel?.action()
    }

    func update(with viewModel: TrendingProjects.Data.ErrorViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        UIView.performWithoutAnimation {
            retryButton.setTitle(viewModel.buttonTitle, for: .normal)
        }
    }
}
