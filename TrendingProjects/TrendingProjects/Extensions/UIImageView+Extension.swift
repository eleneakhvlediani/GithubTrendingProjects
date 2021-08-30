//
//  UIImageView+Extension.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    func lazyLoad(url: String, onSuccess: @escaping (UIImage) -> Void) {
        let imageProviderService = ImageProviderService.shared
        imageProviderService.getImage(with: url) { result in
            switch result {
            case .success(let image):
                onSuccess(image)
            case .failure(let error):
                print(error)
            }
        }
    }

    func setImageWithFadeAnimation(_ image: UIImage, duration: TimeInterval = 0.2) {
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in self?.image = image })
    }
}
