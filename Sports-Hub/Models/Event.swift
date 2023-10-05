//
//  Event.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


struct Event: Codable {
    let id: Int
    let date: String
    let time: String
    let result: String
    let status: String // "" || "Finished"
    
    let season: String
    let round: String?
    let stadium: String?
    
    let leagueLogoURLString: String?
    
    let homeTeamName: String
    let homeTeamLogoURLString: String?
    let awayTeamName: String
    let awayTeamLogoURLString: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "event_key"
        case date = "event_date"
        case time = "event_time"
        case result = "event_final_result"
        case status = "event_status"
        case season = "league_season"
        case round = "league_round"
        case stadium = "event_stadium"
        case leagueLogoURLString = "league_logo"
        case homeTeamName = "event_home_team"
        case homeTeamLogoURLString = "home_team_logo"
        case awayTeamName = "event_away_team"
        case awayTeamLogoURLString = "away_team_logo"
    }
}
