//
//  Football.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


enum Football: AllSportsAPIEndPoint {
    case countries
    case leagues(countryId: Int? = nil)
    
    var path: String {
        return "football"
    }
    
    var met: String {
        switch self {
        case .countries: return "Countries"
        case .leagues: return "Leagues"
        }
    }
    
    var params: [String: Any?] {
        switch self {
        case .leagues(let countryId):
            return ["countryId": countryId]
            
        default:
            return [:]
        }
    }
}
