//
//  RepositoryModel.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 18/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

//Struct criada para trazer os repositorios
struct RepositoriesApiResponse {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
}

extension RepositoriesApiResponse: Decodable {
    private enum RepositoriesApiResponseCodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RepositoriesApiResponseCodingKeys.self)
        
        totalCount = try container.decode(Int.self, forKey: .totalCount)
        incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
        items = try container.decode([Repository].self, forKey: .items)
    }
}
