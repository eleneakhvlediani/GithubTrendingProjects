//
//  UIViewController+Extension.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    func embeddedInNavigationController() -> UINavigationController {
        UINavigationController(rootViewController: self)
    }

    static func instantiateFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            T(nibName: String(describing: T.self), bundle: Bundle(for: self))
        }
        return instantiateFromNib(self)
    }

    func open(url: URL) {
        let svc = SFSafariViewController(url: url)
        svc.modalPresentationStyle = .formSheet
        present(svc, animated: true, completion: nil)
    }

    func displayAlert(title: String?,
                      message: String?,
                      buttonActions: [UIAlertAction]) {
        displayAlert(title: title, message: message, buttonActions: buttonActions, style: .alert)
    }

    private func displayAlert(title: String?,
                              message: String?,
                              buttonActions: [UIAlertAction],
                              style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

        for action in buttonActions {
            alertController.addAction(action)
        }
        present(alertController, animated: true, completion: nil)
    }
}
