//
//  Football.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


enum Football: ASEndPointProvider {
    case countries
    case leagues(countryID: Int? = nil)
    case fixtures(from: String, to: String, timezone: String? = nil, leagueID: Int? = nil)
    case teams(leagueID: Int)
    case team(id: Int)
    
    var path: String {
        return "football"
    }
    
    var met: String {
        switch self {
        case .countries: return "Countries"
        case .leagues: return "Leagues"
        case .fixtures: return "Fixtures"
        case .teams, .team: return "Teams"
        }
    }
    
    var params: [String: Any?] {
        switch self {
        case .leagues(let countryId):
            return ["countryId": countryId]
            
        case .fixtures(let from, let to, let timezone, let leagueID):
            return ["from":from, "to":to, "timezone":timezone, "leagueId":leagueID]
            
        case .team(let id):
            return ["teamId": id]
            
        case .teams(let leagueID):
            return ["leagueId": leagueID]
            
        default:
            return [:]
        }
    }
}
