//
//  ASEndpoint.swift
//  Sports-Hub
//
//  Created by Khater on 07/10/2023.
//

import Foundation


enum ASEndpoint {
    case countries
    case leagues
    case events(from: String, to: String, leagueID: Int)
    case teams(leagueID: Int)
    case team(id: Int)
    
    var params: [String : Any] {
        switch self {
        case .events(let from, let to, let leagueID): return ["from": from, "to": to, "leagueId": leagueID]
        case .teams(let leagueID): return ["leagueId": leagueID]
        case .team(let id): return ["teamId": id]
        default: return [:]
        }
    }
}
