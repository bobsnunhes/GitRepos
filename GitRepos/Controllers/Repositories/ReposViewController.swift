//
//  ReposViewController.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 18/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController {
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    private let repositoryTableViewCellName = "RepositoryTableViewCell"
    private let repositoryCellReuseID = "repositoryCell"
    
    private var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    var repositories: Repositories = Repositories() {
        didSet{
            DispatchQueue.main.async {
                self.repositoriesTableView.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRepositoriesTableView()
        
        loadRepositories()
    }
    
    func loadRepositories(){
        self.networkManager.getNewRepositories { (repositories, error) in
            if let error = error {
                print(error)
            }
            
            if let repositories = repositories {
                self.repositories.totalCount = repositories.totalCount
                self.repositories.incompleteResults = repositories.incompleteResults
                self.repositories.items = repositories.items
            }
        }
    }
    
}

//Controle da TableView
extension ReposViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellReuseID, for: indexPath) as! RepositoryTableViewCell
        
        cell.branchName.text = self.repositories.items[indexPath.row].name
        cell.branchDescription.text = self.repositories.items[indexPath.row].description
        cell.webURL.text = self.repositories.items[indexPath.row].htmlURL
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func setupRepositoriesTableView(){
        //Associa Delegates e Datasources
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        
        //Registra a custom cell
        repositoriesTableView.register(UINib(nibName: repositoryTableViewCellName, bundle: nil), forCellReuseIdentifier: repositoryCellReuseID)
        
        //Dimensiona a tableview automaticamente
        repositoriesTableView.estimatedRowHeight = 68.0
        repositoriesTableView.rowHeight = UITableView.automaticDimension
        
    }
}
