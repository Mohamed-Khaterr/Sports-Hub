//
//  League.swift
//  Sports-Hub
//
//  Created by Khater on 01/10/2023.
//

import Foundation


struct League: Codable {
    let id: Int
    let name: String
    let logoURLString: String
    let countryLogoURLString: String
    
    enum CodingKeys: String, CodingKey {
        case id = "league_key"
        case name = "league_name"
        case logoURLString = "league_logo"
        case countryLogoURLString = "country_logo"
    }
}
