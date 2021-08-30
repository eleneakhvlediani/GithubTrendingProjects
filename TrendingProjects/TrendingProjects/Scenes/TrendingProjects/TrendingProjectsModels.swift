//
//  TrendingProjectsModels.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import UIKit

struct TrendingProjects {
    struct Data {
        struct Response {
            let repositories: [RepositoryRepresentation]
            let searchPhraseIsEmpty: Bool
        }

        struct ViewModel {
            let repositoryCellViewModels: [RepositoryCellViewModel]
            let isSearchVisible: Bool
        }

        struct RepositoryCellViewModel {
            let title: String
            let createdBy: String?
            let description: String?
            let writtenIn: String?
            let color: UIColor?
        }

        struct ErrorViewModel {
            let title: String
            let buttonTitle: String
            let action: (() -> Void)
        }
    }
}
