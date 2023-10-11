//
//  Cricket.swift
//  Sports-Hub
//
//  Created by Khater on 05/10/2023.
//

import Foundation


enum Cricket: ASEndPointProvider {
    case leagues
    case events(from: String, to: String, leagueID: Int? = nil)
    case teams(leagueID: Int)
    case team(id: Int)
    
    var path: String {
        return "cricket"
    }
    
    var met: String {
        switch self {
        case .leagues: return "Leagues"
        case .events(_, _, _): return "Fixtures"
        case .teams(_), .team(_): return "Teams"
        }
    }
    
    var params: [String : Any?] {
        switch self {
        case .events(let from, let to, let leagueID): return ["from": from, "to": to, "leagueId": leagueID]
        case .teams(let leagueID): return ["leagueId": leagueID]
        case .team(let id): return ["teamId": id]
        default: return [:]
        }
    }
}
