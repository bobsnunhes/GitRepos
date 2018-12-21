//
//  NetworkManager.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 19/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import Foundation

struct NetworkManager {
//    static let router = Router<GitHubApi>()
    private let router = Router<GitHubApi>()
    
    init() {}
    //Tratamento de erros para o response da API
    enum NetworkResponse: String {
        case success
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad Request"
        case outdated = "The URL you request is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could not decode the response."
    }

    enum Result<String> {
        case success
        case failure(String)
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getNewRepositories(page: Int, completion: @escaping(_ repositories: Repositories?,_ error: String?)->()){
        router.request(.directories(page: "\(page)")) { (data, response, error) in
            
//            print("DATA = \(String(decoding: data!, as: UTF8.self))")
            if error != nil {
                completion(nil, "Favor verificar a sua conexão com a internet.")
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
}
