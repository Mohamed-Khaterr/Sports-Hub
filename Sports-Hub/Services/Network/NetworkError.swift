//
//  NetworkError.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


enum NetworkError: LocalizedError {
    case noData
    case JSONDecdoing(String)
    case api(String)
    case service(String)
    
    var errorDescription: String? {
        switch self {
        case .noData: return "There is no data"
        case .JSONDecdoing(let dataName): return "Error decoding \(dataName) data"
        case .api(let error): return "API error \n\(error)"
        case .service(let error): return "Service \(error)"
        }
    }
}
