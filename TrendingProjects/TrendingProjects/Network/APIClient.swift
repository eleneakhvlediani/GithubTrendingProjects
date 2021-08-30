//
//  APIClient.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import Alamofire

class APIClient {

    struct EmptyResult: Decodable { }

    let session: Alamofire.Session

    init(session: Alamofire.Session) {
        self.session = session
    }

    func performRequest<T: Decodable>(urlRequest: URLRequestConvertible,
                                      parser: @escaping (Data) throws -> T,
                                      completion: @escaping (Result<T, Error>) -> Void) {
        session
            .request(urlRequest)
            .responseData { (responseData) in
                switch responseData.result {
                case .success(let data):
                    do {
                        let parsedResult = try parser(data)
                        completion(.success(parsedResult))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        }

    }
}
