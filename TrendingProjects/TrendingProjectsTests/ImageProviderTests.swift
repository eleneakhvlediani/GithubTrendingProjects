//
//  ImageProviderTests.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/10/21.
//

import XCTest
@testable import TrendingProjects

class ImageProviderTests: XCTestCase {

    var imageProviderService: ImageProviderService!
    var cache: NSCache<NSString, UIImage>!
    var imageDownloader: ImageDownloader!
    override func setUpWithError() throws {
        cache = NSCache<NSString, UIImage>()
        imageDownloader = MockedImageDownloader()
        imageProviderService = ImageProviderService(cache: cache, imageDownloader: imageDownloader)
    }

    func testDownloadingImage() throws {
        imageProviderService.getImage(with: "test") { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTFail()
            }
        }
    }

    func testCachedImage() throws {
        imageProviderService.getImage(with: "test") { result in
            switch result {
            case .success(let img):
                XCTAssert(img == self.cache.object(forKey: NSString(string: "test")))
            case .failure:
                XCTFail()
            }
        }

    }
}

class MockedImageDownloader: ImageDownloader {
    enum Error: Swift.Error {
        case mockedError
    }
    var successDownload: Bool = true
    func downloadImage(from url: URL, completionHandler: @escaping (Result<Data, Swift.Error>) -> Void) {
        if successDownload {
            let img = #imageLiteral(resourceName: "error")
            completionHandler(.success(img.pngData()!))
        } else {
            completionHandler(.failure(Error.mockedError))
        }
    }
}
