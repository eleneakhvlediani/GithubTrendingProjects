//
//  RepositoryTableViewCell.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func update(with model: TrendingProjects.Data.RepositoryCellViewModel) {
        titleLabel.text = model.title
        descriptionLabel.isHidden = model.createdBy == nil
        descriptionLabel.text = model.createdBy
        bodyLabel.isHidden = model.description == nil
        bodyLabel.text = model.description
        languageLabel.isHidden = model.writtenIn == nil
        languageLabel.text = model.writtenIn
        languageLabel.textColor = model.color
    }
}
