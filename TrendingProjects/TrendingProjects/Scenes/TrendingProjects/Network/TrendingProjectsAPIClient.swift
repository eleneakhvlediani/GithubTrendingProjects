//
//  TrendingProjectsAPIClient.swift
//  Trending Projects
//
//  Created by Elene_Akhvlediani on 7/6/21.
//

import Foundation
import Alamofire

final class TrendingProjectsAPIClient: APIClient {

    init() {
        super.init(session: Alamofire.Session.default)
    }

    func getTrendingProjects(completion: @escaping (Result<[RepositoryRepresentation], Error>) -> Void) {
        let endpoint = TrendingProjectsRequest.GetRepositories()
        performRequest(urlRequest: endpoint,
                       parser: { try JSONDecoder().decode([RepositoryRepresentation].self, from: $0)},
                       completion: completion)
    }
}
