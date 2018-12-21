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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    
    private let repositoryTableViewCellName = "RepositoryTableViewCell"
    private let repositoryCellReuseID = "repositoryCell"
    private let repositoryDetailSegue = "repositoryDetailSegue"
    
    //Controla a pagina a ser utilizada na URL
    private var indexOfPageRequest: Int = 1
    
    //Controla Fetch da tabela
    private var fetchingMore = false
    
    //Instancia o network manager para chamar os métodos da API 
    private var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    //Cria var para armazenar os repositórios
    var repositories: Repositories = Repositories() {
        //Atualiza tabela na view sempre que os repositórios são atualizados
        didSet{
            fetchingMore = false
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
    
    //MARK: loadRepositories - Carrega os repositorios da API para a stuct de acordo com a pagina
    private func loadRepositories(){
        startLoadingTableView()
        self.networkManager.getNewRepositories(page: indexOfPageRequest) { (repositories, error) in
            if let error = error {
                print(error)
                self.stopLoadingTableView()
            }
            
            if let repositories = repositories {
                self.repositories.totalCount = repositories.totalCount
                self.repositories.incompleteResults = repositories.incompleteResults
                for newItem in repositories.items {
                    self.repositories.items.append(newItem)
                }
                
                DispatchQueue.main.async {
                    self.repositoriesTableView.reloadData()
                    self.stopLoadingTableView()
                }
            }
        }
    }
    
    //MARK: prepare for Segue - Passa informação do repositório selecionado para view de detalhes.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == repositoryDetailSegue), let selectedRepository = sender as? Repository {
            let repositoryPullDetailsVC = segue.destination as! RepositoryPullDetailsViewController
            repositoryPullDetailsVC.repository = selectedRepository
        }
    }
}

//Controle da TableView
extension ReposViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: didSelectRowAt - Chama tela de detalhes quando usuário clica na linha da tabela
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRepository: Repository = repositories.items[indexPath.row]
        
        performSegue(withIdentifier: repositoryDetailSegue, sender: selectedRepository)
    }
    
    //MARK: numberOfRowsInSection - Controla a quantidade de linhas por seção.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.items.count
    }
    
    //MARK: cellForRowAt - Preenche cada linha de acordo com a lógica abaixo
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellReuseID, for: indexPath) as! RepositoryTableViewCell
        
        //Atribui o valor para os campos de acordo com a linha da tabela acessando os dados da struct
        cell.branchName.text = self.repositories.items[indexPath.row].name
        cell.branchDescription.text = self.repositories.items[indexPath.row].description
        cell.author.text = self.repositories.items[indexPath.row].owner.login
        cell.webURL.text = self.repositories.items[indexPath.row].htmlURL
        cell.language.text = self.repositories.items[indexPath.row].language
        cell.defaultBranch.text = self.repositories.items[indexPath.row].defaultBranch
        cell.creationDate.text = self.repositories.items[indexPath.row].createdAt
        cell.lastUpdate.text = self.repositories.items[indexPath.row].updatedAt
        cell.stargazers.text = String(self.repositories.items[indexPath.row].stargazersCount)
        cell.forks.text = String(self.repositories.items[indexPath.row].forksCount)
        
        return cell
    }
    
    //MARK: heightForRowAt - Configura tabela como Automatic Dimension
    //Assim a linha da tabela deve ter seu tamanho automatico baseado em seu conteudo.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK: scrollViewDidScroll - Controla Fetch dos registros pelo scroll da tabela
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    //MARK: beginBatchFetch - Controla fetch da tabela pra disparar somente uma vez por scroll rolado
    private func beginBatchFetch() {
        fetchingMore = true
        print("page = \(indexOfPageRequest)")
        self.indexOfPageRequest += 1
        self.loadRepositories()
    }
    
    //MARK: setupRepositoriesTableView - Configuração inicial da table view dos repositórios.
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
    
    //MARK: Controles para o Activity Indicator
    func startLoadingTableView(){
        DispatchQueue.main.async {
            self.blurEffectView.isHidden = false
            self.blurEffectView.alpha = 1.0
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopLoadingTableView(){
        DispatchQueue.main.async {
            self.blurEffectView.isHidden = true
            self.blurEffectView.alpha = 0.0
            self.activityIndicator.stopAnimating()
        }
    }
}
