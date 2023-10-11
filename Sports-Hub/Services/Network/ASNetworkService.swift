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
    
    func fetch<T: Decodable>(_ type: T.Type, endpoint: ASEndPointProvider, compeletionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        let endpointManager = ASEndPointProviderManager(endpoint)
        
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
    
    func fetch<T: Decodable>(_ type: T.Type, sport: SportType, endpoint: ASEndPoint, compeletionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        let urlString = getURLString(sportType: sport)
        
        var params = endpoint.params
        params["met"] = endpoint.met
        params["APIkey"] = Hidden.apiKey
        
        AF.request(urlString, method: .get, parameters: params).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    compeletionHandler(.failure(.noData))
                    return
                }
                
                do {
                    if let result = try self.parseJSONASResponse(type, from: data) {
                        compeletionHandler(.success(result))
                    } else {
                        compeletionHandler(.failure(.noData))
                    }
                    
                } catch {
                    compeletionHandler(.failure(error as! NetworkError))
                }
                
            case .failure(let error):
                // Network Error
                compeletionHandler(.failure(.service(error.localizedDescription)))
            }
        }
    }
    
    private func getURLString(sportType: SportType) -> String {
        let baseURL = "https://apiv2.allsportsapi.com"
        let path: String
        switch sportType {
        case .football: path = "football"
        case .basketball: path = "basketball"
        case .cricket: path = "cricket"
        }
        let urlString = baseURL + "/\(path)"
        return urlString
    }
    
    private func parseJSONASResponse<T: Decodable>(_ type: T.Type, from data: Data) throws -> T? {
        do {
            let decodedData = try JSONDecoder().decode(ASDataResponse<T>.self, from: data)
            
            return decodedData.result

        } catch {
            do {
                // AllSportsAPI response with error
                let decodedError = try JSONDecoder().decode(ASErrorResponse.self, from: data)
                let errorMessage = decodedError.result.compactMap({ $0.message }).joined(separator: ", ")
                throw NetworkError.api(errorMessage) as Error
            } catch {
                // Parsing JSON error
                debugPrint("Developer Error :: Data Model is not compatible with API Response. Please Check your URL and Data Model")
                throw NetworkError.JSONDecdoing(error.localizedDescription) as Error
            }
        }
    }
}
