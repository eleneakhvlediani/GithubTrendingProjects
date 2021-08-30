//
//  ImageDownloader.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import Alamofire

protocol ImageDownloader {
    func downloadImage(from url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void )
}

final class AlamofireImageDownloader: ImageDownloader {
    func downloadImage(from url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
