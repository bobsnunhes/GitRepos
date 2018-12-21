//
//  RepositoryPullDetailsViewController.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 18/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import UIKit

class RepositoryPullDetailsViewController: UIViewController {
    
    @IBOutlet weak var pullTableView: UITableView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let repositoryDetailSegue = "repositoryDetailSegue"
    private let pullCellID = "pullDetailsCellID"
    private let tableViewCellName = "PullDetailsTableViewCell"
    
    //Recebe o repositório através de injection por Segue
    var repository: Repository?
    
    //Lista de detalhes de push do diretório
    var repositoryPulls: RepositoryPullDetails?
    
    //Instancia o network manager para chamar os métodos da API
    private var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPullTableView()
        
        if let repos = repository {
            getRepositoryPushDetails(repository: repos)
        }
    }
    
    private func getRepositoryPushDetails(repository: Repository){
        startLoadingTableView()
        self.networkManager.getRepositoryDetail(owner: repository.owner.login, repository: repository.name) { (repositoryDetail, error) in
            if let error = error {
                print(error)
            }
            
            if let repDetails = repositoryDetail{
                self.repositoryPulls = repDetails
                self.stopLoadingTableView()
                DispatchQueue.main.async {
                    self.pullTableView.reloadData()
                }
            }
        }
    }
}

//Controle da TableView
extension RepositoryPullDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositoryPulls?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pullCellID, for: indexPath) as! PullDetailsTableViewCell
        
        if let cellPull = repositoryPulls?[indexPath.row] {
            cell.title.text = cellPull.title
            
            if let date: Date = cellPull.createdAt.parseToDate() {
                cell.bottonMessage.text = "#\(cellPull.number) aberto a \(getDaysBetweenDates(startDate: date, endDate: Date())) dias por \(cellPull.user.login)"
            }
        }
        
        return cell
        
    }
    
    //MARK: getDaysBetweenDates - Pega o número de dias entre duas datas
    private func getDaysBetweenDates(startDate: Date, endDate: Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        return components.day!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    private func setupPullTableView() {
        //Associa Delegates e Datasources
        pullTableView.delegate = self
        pullTableView.dataSource = self
        
        //Registra a custom cell
        pullTableView.register(UINib(nibName: tableViewCellName, bundle: nil), forCellReuseIdentifier: pullCellID)
        
        //Dimensiona a tableview automaticamente
        pullTableView.estimatedRowHeight = 78.0
        pullTableView.rowHeight = UITableView.automaticDimension
    }
    
    //MARK: Controles para o Activity Indicator
    func startLoadingTableView(){
        DispatchQueue.main.async {
            self.blurView.isHidden = false
            self.blurView.alpha = 1.0
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopLoadingTableView(){
        DispatchQueue.main.async {
            self.blurView.isHidden = true
            self.blurView.alpha = 0.0
            self.activityIndicator.stopAnimating()
        }
    }
}
