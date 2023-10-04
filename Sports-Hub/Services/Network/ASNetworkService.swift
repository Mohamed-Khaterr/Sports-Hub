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
    
    func fetch<T: Decodable>(_ type: T.Type, endpoint: ASEndPoint, compeletionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        let endpointManager = ASEndPointManager(endpoint)
        
        AF.request(endpointManager.urlString(), method: .get, parameters: endpointManager.parameters()).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    compeletionHandler(.failure(.noData))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(ASDataResponse<T>.self, from: data)
                    
                    if let result = decodedData.result {
                        compeletionHandler(.success(result))
                    } else {
                        compeletionHandler(.failure(.noData))
                    }

                } catch {
                    do {
                        // AllSportsAPI response with error
                        let decodedError = try JSONDecoder().decode(ASErrorResponse.self, from: data)
                        let errorMessage = decodedError.result.compactMap({ $0.message }).joined(separator: ", ")
                        compeletionHandler(.failure(.api(errorMessage)))
                    } catch {
                        // Parsing JSON error
                        compeletionHandler(.failure(.JSONDecdoing(error.localizedDescription)))
                        debugPrint("Developer Error :: Data Model is not compatible with API Response. Please Check your URL and Data Model")
                    }
                }
                
            case .failure(let error):
                // Network Error
                compeletionHandler(.failure(.service(error.localizedDescription)))
            }
        }
    }
}
