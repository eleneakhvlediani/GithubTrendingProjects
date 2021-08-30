//
//  RepositoryModels.swift
//  TrendingProjects
//
//  Created by Elene_Akhvlediani on 7/8/21.
//

import Foundation
import UIKit

struct Repository {
    struct ViewModel {
        struct Language {
            let title: String
            let value: String
            let color: UIColor
        }
        let title: String
        let description: String
        let starsTitle: String
        let forksTitle: String
        let userName: String
        let userAvatarURL: String?
        let language: Language
        let openRepositoryButtonTitle: String
    }

    struct ErrorViewModel {
        let title: String
        let buttonTitle: String
    }
}

