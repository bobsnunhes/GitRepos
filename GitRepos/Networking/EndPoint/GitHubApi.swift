//
//  GitHubApi.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 18/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

public enum GitHubApi: EndPointType {
    var queryItens: [URLQueryItem]? {
        switch self {
        case .directories:
            return [
                URLQueryItem(name: "q", value: "language:Java"),
                URLQueryItem(name: "sort", value: "starts")
            ]
        case .directoryDetail:
            return nil
        }
    }
    
    case directories
    case directoryDetail(owner: String, repositoryID: String)
    
    var enviromentBaseURL: String {
        return "https://api.github.com/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: enviromentBaseURL) else { fatalError("baseURL could not be generated")}
        return url
    }
    
    var path: String {
        switch self {
        case .directories:
//            return "search/repositories?q=language:Java&sort=stars"
            return "search/repositories"
        case .directoryDetail(let owner, let repositoryID):
            return "repos/\(owner)/\(repositoryID)/pulls"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil 
    }
    
    
}
