//
//  UITableView+Extension.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import UIKit

public extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.defaultReuseIdentifier(), for: indexPath) as? T else {
            fatalError("dequeueReusableCell of type :\(T.self) failed. Probably cell was not registered")
        }
        return cell
    }

    func register<T: UITableViewCell>(cell: T.Type) {
        self.register(cell, forCellReuseIdentifier: cell.defaultReuseIdentifier())
    }

    func registerNib<T: UITableViewCell>(cell: T.Type) {
        self.register(cell.nib(), forCellReuseIdentifier: cell.defaultReuseIdentifier())
    }

    @objc(installInView:withStyle:)
    static func install(in view: UIView, with style: UITableView.Style) -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: style)
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        return tableView
    }
}
