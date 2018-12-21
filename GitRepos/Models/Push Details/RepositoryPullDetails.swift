//
//  RepositoryPullDetails.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 21/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

typealias RepositoryPullDetails = [RepositoryPullDetail]

struct RepositoryPullDetail {
    var number: Int
    var title: String
    var user: User
    var createdAt: String
    var labels: [Label]
}

extension RepositoryPullDetail: Decodable {
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
        createdAt = try repositoryContainer.decode(String.self, forKey: .createdAt)
        labels = try repositoryContainer.decode([Label].self, forKey: .labels)
    }
}
