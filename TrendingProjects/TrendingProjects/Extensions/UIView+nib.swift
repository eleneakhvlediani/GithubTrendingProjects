//
//  UIView+nib.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import UIKit
extension UIView {
   static func nib() -> UINib? {
        let namespaceClassName = NSStringFromClass(self)
        if let className = namespaceClassName.components(separatedBy: ".").last {
            return UINib(nibName: className, bundle: Bundle(for: self))
        }
        return nil
    }

    static func loadFromNib() -> Self? {
        loadFromNibHelper()
    }

    static func loadFromNibHelper<T>() -> T? {
        nib()?.instantiate(withOwner: nil, options: nil).last as? T
    }

    func fadeTransition(duration: TimeInterval, _ animationBlock: () -> Void) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
        animationBlock()
    }

    func pinEdges(to other: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: other.leadingAnchor),
            trailingAnchor.constraint(equalTo: other.trailingAnchor),
            topAnchor.constraint(equalTo: other.topAnchor),
            bottomAnchor.constraint(equalTo: other.bottomAnchor)
        ])
    }

    func showWithAnimation(duration: TimeInterval = 0.5) {
        guard isHidden else { return }
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: duration) { [weak self] in
            self?.alpha = 1
        }
    }
}
