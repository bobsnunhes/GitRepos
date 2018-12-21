//
//  Label.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 21/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

struct Label{
    let name: String
}

extension Label: Decodable {
    enum LabelApiResponseCodingKeys: String, CodingKey {
        case name 
    }
    
    init(from decoder: Decoder) throws {
        let repositoryContainer = try decoder.container(keyedBy: LabelApiResponseCodingKeys.self)
        
        name = try repositoryContainer.decode(String.self, forKey: .name)
    }
}
