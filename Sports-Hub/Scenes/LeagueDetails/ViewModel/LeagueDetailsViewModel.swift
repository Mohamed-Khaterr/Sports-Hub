//
//  LeagueDetailsViewModel.swift
//  Sports-Hub
//
//  Created by Khater on 30/09/2023.
//

import Foundation


class LeagueDetailsViewModel {
    private var data: [Int] = []
    
    var noOfSections: Int {
        return 3
    }
    
    var noOfItems: Int {
        return 5
    }
    
    func configHeaderView(_ header: CVHeaderViewProtocol, atSection section: Int) {
        header.configure()
        switch section {
        case 0: header.setTitle("Upcoming Events")
        case 1: header.setTitle("Leates Events")
        case 2: header.setTitle("Teams")
        default: return
        }
    }
    
    func configEventCell(_ cell: EventCellView, atIndex index: Int, andSection section: Int) {
        cell.setupCellUI()
        cell.setDate("13-09-2023")
        cell.setTime("10:00 PM")
        cell.setNames(homeTeam: "Arsenal", awayTeam: "Chalse")
        cell.setImages(league: URL(string: "https://png2.cleanpng.com/sh/5589244d7f211be217e110366b1dc8c6/L0KzQYm3V8EyN6drgZH0aYP2gLBuTcIxOWc2T595cnXwebb5TfxmaZh6fZ9ubnfvecTvTfZwd6Vned51LXzocbj8hb1tNZ1uh9C2ZX3yerq0VfI1PmFrSKk7MkK3QIK1UcQ4P2k8Tac6NUO0Q4KBUMI0OWQAUZD5bne=/kisspng-201617-premier-league-english-football-league-l-lion-emoji-5b460f07222401.1477875515313180231399.png"),
                       homeTeam: URL(string: "https://assets.stickpng.com/images/580b57fcd9996e24bc43c4e1.png"),
                       awayTeam: URL(string: "https://assets.stickpng.com/images/580b57fcd9996e24bc43c4df.png"))
        
        if section == 0 {
            cell.hideScore()
        } else {
            cell.setScore("4 - 1")
        }
    }
}
