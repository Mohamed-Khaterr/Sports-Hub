//
//  EventCellView.swift
//  Sports-Hub
//
//  Created by Khater on 27/09/2023.
//

import Foundation


protocol EventCellView {
    func setupCellUI()
    func setImages(league: URL?, homeTeam: URL?, awayTeam: URL?)
    func setNames(homeTeam: String, awayTeam: String)
    func setScore(_ score: String)
    func hideScore()
    func setTime(_ time: String)
    func setDate(_ date: String)
}
