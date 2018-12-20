//
//  Repositories.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 18/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

//Struct criada para trazer os repositorios
struct Repositories {
    var totalCount: Int = 0
    var incompleteResults: Bool = false
    var items = [Repository]()
    
    init() {}
    
}

extension Repositories: Decodable {
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
