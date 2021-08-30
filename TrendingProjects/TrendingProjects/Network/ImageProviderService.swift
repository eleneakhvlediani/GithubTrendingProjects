//
//  ImageProviderService.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import UIKit

final class ImageProviderService {
    enum Error: Swift.Error {
        case missingDownloadURL
        case badURL
        case dataCorrupted
        case downloadFailed
    }

    static let shared = ImageProviderService()

    private let imagesCache: NSCache<NSString, UIImage>
    private let imageDownloader: ImageDownloader

    init(cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>(), imageDownloader: ImageDownloader = AlamofireImageDownloader()){
        self.imagesCache = cache
        self.imageDownloader = imageDownloader
    }

    func getImage(with url: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void ) {
        if let cachedImage = object(forKey: url) {
            completionHandler(.success(cachedImage))
        } else {
            downloadImage(with: url, completionHandler: completionHandler)
        }
    }

    private func downloadImage(with urlString: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void ) {
        guard let url = URL(string: urlString) else { return completionHandler(.failure(.badURL)) }
        imageDownloader.downloadImage(from: url) { [weak self] result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self?.setObject(image: image, forKey: urlString)
                    completionHandler(.success(image))
                } else {
                    completionHandler(.failure(.dataCorrupted))
                }
            case .failure:
                completionHandler(.failure(.downloadFailed))
            }
        }

    }

    private func object(forKey key: String) -> UIImage? { imagesCache.object(forKey: NSString(string: key)) }

    private func setObject(image: UIImage, forKey key: String) {
        imagesCache.setObject(image, forKey: NSString(string: key))
    }
}
