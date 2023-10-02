//
//  ASNetworkService.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation
import Alamofire


struct ASNetworkService: ASNetworkProvider {
    static let shared = ASNetworkService()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, endpoint: ASEndPoint, compeletionHandler: @escaping (Result<T, Error>) -> Void) {
        let endpointManager = ASEndPointManager(endpoint)
        AF.request(endpointManager.urlString(), method: .get, parameters: endpointManager.parameters()).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(ASDataResponse<T>.self, from: data)
                    if let result = decodedData.result {
                        compeletionHandler(.success(result))
                    }
                   
                } catch {
                    do {
                        // AllSportsAPI response with error
                        let decodedError = try JSONDecoder().decode(ASErrorResponse.self, from: data)
                        compeletionHandler(.failure(error))
                    } catch {
                        // Parsing JSON error
                        compeletionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                // Network Error
                print(error)
            }
        }
    }
}
