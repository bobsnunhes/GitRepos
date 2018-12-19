//
//  Repository.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 19/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

//Struct criada para armazenar as informações de cada repositorio
struct Repository {
    let id: Int
    let name: String
    let owner: Owner
    let htmlURL: String
    let description: String
    let createdAt, updatedAt: String
    let stargazersCount: Int
    let language: String
    let forksCount: Int
    let defaultBranch: String
    
}

extension Repository: Decodable {
    
    enum RepositoryApiResponseCodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case htmlURL = "html_url"
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
        case language
        case forksCount = "forks_count"
        case defaultBranch = "default_branch"
    }
    
    init(from decoder: Decoder) throws {
        let repositoryContainer = try decoder.container(keyedBy: RepositoryApiResponseCodingKeys.self)
        
        id = try repositoryContainer.decode(Int.self, forKey: .id)
        name = try repositoryContainer.decode(String.self, forKey: .name)
        owner = try repositoryContainer.decode(Owner.self, forKey: .owner)
        htmlURL = try repositoryContainer.decode(String.self, forKey: .htmlURL)
        description = try repositoryContainer.decode(String.self, forKey: .description)
        createdAt = try repositoryContainer.decode(String.self, forKey: .createdAt)
        updatedAt = try repositoryContainer.decode(String.self, forKey: .updatedAt)
        stargazersCount = try repositoryContainer.decode(Int.self, forKey: .stargazersCount)
        language = try repositoryContainer.decode(String.self, forKey: .language)
        forksCount = try repositoryContainer.decode(Int.self, forKey: .forksCount)
        defaultBranch = try repositoryContainer.decode(String.self, forKey: .defaultBranch)
    }
}
