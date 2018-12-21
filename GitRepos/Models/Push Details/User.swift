//
//  User.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 21/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

struct User {
    let login: String
    let avatarURL: String
}

extension User: Decodable {
    enum UserResponseCodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let repositoryContainer = try decoder.container(keyedBy: UserResponseCodingKeys.self)
        
        login = try repositoryContainer.decode(String.self, forKey: .login)
        avatarURL = try repositoryContainer.decode(String.self, forKey: .avatarURL)
    }
}
