//
//  EventCellView.swift
//  Sports-Hub
//
//  Created by Khater on 27/09/2023.
//

import Foundation


protocol EventCellView {
    func setupCellUI()
    func setLeagueImage(withURL url: URL?, defaultImage: String?)
    func setHomeTeamImage(withURL url: URL?, defaultImage: String?)
    func setAwayTeamImage(withURL url: URL?, defaultImage: String?)
    func setNames(homeTeam: String, awayTeam: String)
    func setScore(_ score: String)
    func hideScore()
    func setTime(_ time: String)
    func setDate(_ date: String)
}
