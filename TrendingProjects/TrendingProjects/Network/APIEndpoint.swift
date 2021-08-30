//
//  APIEndpoint.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import Alamofire

protocol APIEndpoint: URLRequestConvertible {
    var baseURLString: String { get }
    var parameters: [String: Any] { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var apiKey: String { get }
    var parametersEncoding: ParameterEncoding { get }
}

extension APIEndpoint {
    var parametersEncoding: ParameterEncoding { return URLEncoding.default }
    var apiKey: String { return "a2255e3de64340e9980e8a0780d2752a" }
    func asURLRequest() throws -> URLRequest {
        let baseUrl = try baseURLString.asURL()
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try parametersEncoding.encode(urlRequest, with: parameters)
    }
}
