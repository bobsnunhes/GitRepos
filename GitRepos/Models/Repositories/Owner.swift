//
//  Owner.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 19/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

struct Owner {
    var login: String
    var id: Int
    var avatarURL: String
}

extension Owner: Decodable {
    
    enum OwnerCodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let ownerContainer = try decoder.container(keyedBy: OwnerCodingKeys.self)
        
        login = try ownerContainer.decode(String.self, forKey: .login)
        id = try ownerContainer.decode(Int.self, forKey: .id)
        avatarURL = try ownerContainer.decode(String.self, forKey: .avatarURL)
    }
}
