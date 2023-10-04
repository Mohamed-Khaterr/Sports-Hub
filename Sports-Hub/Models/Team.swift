//
//  Team.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


struct Team: Codable {
    let id: Int
    let name: String
    let logoURLString: String
    let players: [Player]
    let coaches: [Coach]
    
    enum CodingKeys: String, CodingKey {
        case id = "team_key"
        case name = "team_name"
        case logoURLString = "team_logo"
        case players
        case coaches
    }
}


struct Player: Codable {
    let id: Int
    let name: String
    let age: String
    let birthdate: String
    let number: String
    let position: String
    let rate: String
    let imageURLString: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "player_key"
        case name = "player_name"
        case age = "player_age"
        case birthdate = "player_birthdate"
        case number = "player_number"
        case position = "player_type"
        case rate = "player_rating"
        case imageURLString = "player_image"
    }
}


struct Coach: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "coach_name"
    }
}
