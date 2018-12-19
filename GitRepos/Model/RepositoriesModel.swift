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

//Struct criada para armazenar as informações de cada repositorio 
struct Repository {
    
    let id: Int
    let name: String
    let owner: Owner
    let websiteURL: String
    let description: String
    let language: String
    let defaultBranch: String
    let starts: Int
    let forks: Int
    let creationDate: Date
    let lastUpdateDate: Date
    
}

extension Repository: Decodable {

    enum RepositoryApiResponseCodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case websiteURL = "html_url"
        case description
        case language
        case defaultBranch = "default_branch"
        case stars = "stargazers_count"
        case forks = "forks_count"
        case creationDate = "created_at"
        case lastUpdateDate = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let repositoryContainer = try decoder.container(keyedBy: RepositoryApiResponseCodingKeys.self)

        id = try repositoryContainer.decode(Int.self, forKey: .id)
        name = try repositoryContainer.decode(String.self, forKey: .name)
        owner = try repositoryContainer.decode(Owner.self, forKey: .owner)
        websiteURL = try repositoryContainer.decode(String.self, forKey: .websiteURL)
        description = try repositoryContainer.decode(String.self, forKey: .description)
        language = try repositoryContainer.decode(String.self, forKey: .language)
        defaultBranch = try repositoryContainer.decode(String.self, forKey: .defaultBranch)
        starts = try repositoryContainer.decode(Int.self, forKey: .stars)
        forks = try repositoryContainer.decode(Int.self, forKey: .forks)
        creationDate = try repositoryContainer.decode(Date.self, forKey: .creationDate)
        lastUpdateDate = try repositoryContainer.decode(Date.self, forKey: .lastUpdateDate)
    }
}
