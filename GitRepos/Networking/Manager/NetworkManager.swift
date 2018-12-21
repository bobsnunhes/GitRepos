//
//  NetworkManager.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 19/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

struct NetworkManager {

    private let router = Router<GitHubApi>()
    
    init() {}
    //Tratamento de erros para o response da API
    enum NetworkResponse: String {
        case success
        case authenticationError = "Erro de autenticação."
        case badRequest = "Erro ao realizar o request."
        case outdated = "A URL utilizada no request está desatualizada."
        case failed = "Falha de rede, verifique sua conexão."
        case noData = "O response não retornou dados."
        case unableToDecode = "Não foi possível realizar o decode no response."
    }

    enum Result<String> {
        case success
        case failure(String)
    }
    
    //MARK: Tratamento de StatusCode
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    //MARK: getNewRepositories - Busca os repositórios por página
    func getNewRepositories(page: Int, completion: @escaping(_ repositories: Repositories?,_ error: String?)->()){
        router.request(.directories(page: "\(page)")) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkResponse.failed.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Repositories.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch let error {
                        completion(nil, error.localizedDescription)
                    }
                case .failure(let networkFailureError): completion(nil, networkFailureError)
                }
            }
        }
    }
    
    //MARK: getRepositoryDetail - Busca os detalhes do pull de determinado repositório
    func getRepositoryDetail(owner: String, repository: String, completion: @escaping(_ repositoryPullDetails: RepositoryPullDetails?, _ error: String?) ->()) {
        router.request(.directoryDetail(owner: owner, repository: repository)) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkResponse.failed.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(RepositoryPullDetails.self, from: responseData)
                       
                        completion(apiResponse,nil)
                    } catch let error {
                        completion(nil, error.localizedDescription)
                    }
                case .failure(let networkFailureError): completion(nil, networkFailureError)
                }
            }
        }
    }
}
