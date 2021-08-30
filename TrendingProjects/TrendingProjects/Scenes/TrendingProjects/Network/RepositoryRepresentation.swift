//
//  TopArticles.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import UIKit

struct RepositoryRepresentation: Decodable {
    struct User: Decodable {
        let username: String
        let avatar: String?
        let href: String
    }
    let name: String
    let author: String
    let avatar: String?
    let url: String?
    let description: String
    let language: String
    let languageColor: String?
    let stars: Int
    let forks: Int
    let currentPeriodStars: Int
    let builtBy: [User]

    var languageTextColor: UIColor? {
        languageColor.map { UIColor(hexaString: $0) } ?? nil
    }
}

extension UIColor {
    convenience init(hexaString: String, alpha: CGFloat = 1) {
        let chars = Array(hexaString.dropFirst())
        self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                  green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                  blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                  alpha: alpha)}
}
