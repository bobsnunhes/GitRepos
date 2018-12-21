//
//  RepositoryPushDetails.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 21/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

struct RepositoryPushDetails {
    let number: Int
    let title: String
    let user: User
    let createdAt: Date
    let labels: [Label]
}

extension RepositoryPushDetails: Decodable {
    enum DetailsResponseCodingKeys: String, CodingKey {
        case number, title, user
        case createdAt = "created_at"
        case labels
    }
    
    init(from decoder: Decoder) throws {
        let repositoryContainer = try decoder.container(keyedBy: DetailsResponseCodingKeys.self)
        
        number = try repositoryContainer.decode(Int.self, forKey: .number)
        title = try repositoryContainer.decode(String.self, forKey: .title)
        user = try repositoryContainer.decode(User.self, forKey: .user)
        createdAt = try repositoryContainer.decode(Date.self, forKey: .createdAt)
        labels = try repositoryContainer.decode([Label].self, forKey: .labels)
    }
}
