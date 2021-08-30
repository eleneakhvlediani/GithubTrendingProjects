//
//  UITableViewCell+CellProtocol.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import UIKit
protocol CellProtocol {
    static func defaultReuseIdentifier() -> String
}

extension UITableViewCell: CellProtocol {
    class func defaultReuseIdentifier() -> String { NSStringFromClass(self) }
}
