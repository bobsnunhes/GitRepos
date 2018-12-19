//
//  ReposViewController.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 18/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController {

    private lazy var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getNewRepositories { (repositories, error) in
            if let error = error {
                print(error)
            }
            
            if let repositories = repositories {
                print(repositories)
            }
        }
    }
}

