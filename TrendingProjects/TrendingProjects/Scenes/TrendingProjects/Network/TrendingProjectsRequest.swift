//
//  TrendingProjectsRequest.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import Alamofire

struct TrendingProjectsRequest {

    struct GetRepositories: APIEndpoint {
        let baseURLString: String = "https://private-anon-acfb800737-githubtrendingapi.apiary-mock.com"
        let method: HTTPMethod = .get
        var parameters: [String : Any] { [:] }
        var path: String { "repositories" }
    }

}
