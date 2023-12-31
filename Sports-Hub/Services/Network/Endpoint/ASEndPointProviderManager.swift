//
//  ASEndPointProviderManager.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


struct ASEndPointProviderManager {
    // Hide API
    private let apiKey = Hidden.apiKey
    private let baseURLString = "https://apiv2.allsportsapi.com"
    
    private let endpoint: ASEndPointProvider
    
    init(_ action: ASEndPointProvider) {
        self.endpoint = action
    }
    
    
    func urlString() -> String {
        return baseURLString + "/\(endpoint.path)"
    }
    
    func parameters() -> [String: Any] {
        var parameters = endpoint.params.compactMapValues{ $0 }
        parameters["APIkey"] = apiKey
        parameters["met"] = endpoint.met
        return parameters
    }
}
