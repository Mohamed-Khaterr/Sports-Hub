//
//  LeagueDetailsViewModel.swift
//  Sports-Hub
//
//  Created by Khater on 30/09/2023.
//

import Foundation


class LeagueDetailsViewModel {
    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event] = []
    private var teams: [Team] = []
    
    var showLoadingIndicator: ((Bool) -> Void)?
    var render: (() -> Void)?
    var errorOccurred: ((String) -> Void)?
    
    var noOfSections: Int {
        return 3
    }
    
    func noOfItems(in section: Int) -> Int {
        // TODO: Search if you can make this dictionary
        switch section {
        case 0: return upcomingEvents.count
        case 1: return latestEvents.count
        case 2: return teams.count
        default: return 0
        }
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
        switch section {
        case 0:
            let event = upcomingEvents[index]
            cell.setupCellUI()
            cell.hideScore()
            cell.setDate(event.date ?? "")
            cell.setTime(event.time)
            cell.setNames(homeTeam: event.homeTeamName, awayTeam: event.awayTeamName)
            cell.setImages(league: URL(string: event.leagueLogoURLString ?? ""),
                           homeTeam: URL(string: event.homeTeamLogoURLString ?? ""),
                           awayTeam: URL(string: event.awayTeamLogoURLString ?? ""))
        case 1:
            let event = latestEvents[index]
            cell.setupCellUI()
            cell.setScore(event.result ?? "")
            cell.setDate(event.date ?? "")
            cell.setTime(event.time)
            cell.setNames(homeTeam: event.homeTeamName, awayTeam: event.awayTeamName)
            cell.setImages(league: URL(string: event.leagueLogoURLString ?? ""),
                           homeTeam: URL(string: event.homeTeamLogoURLString ?? ""),
                           awayTeam: URL(string: event.awayTeamLogoURLString ?? ""))
        default: return
        }
    }
    
    func configTeamCell(_ cell: CollectionViewCell, atIndex index: Int) {
        let team = teams[index]
        cell.team_image.setImage(withURL: URL(string: team.logoURLString ?? ""))
        cell.team_label.text = team.name
    }
    
    private func getData(withNextYear returnNextYear: Bool) -> (String, String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDataString = formatter.string(from: Date())
        //let nextYearDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())! // API Error: The difference between to and from cannot be greater than 15 days if there is no other parameter
        let nextYearDate = Calendar.current.date(byAdding: .day, value: 15, to: Date())!
        let nextYearString = formatter.string(from: nextYearDate)
        
        let lastYearData = Calendar.current.date(byAdding: .day, value: -15, to: Date())!
        let lastYearString = formatter.string(from: lastYearData)
        
        if returnNextYear {
            return (currentDataString, nextYearString)
        } else {
            return (currentDataString, lastYearString)
        }
    }
    
    func fetchUpcomingEvents() {
        showLoadingIndicator?(true)
        let (currentDate, nextYearDate) = getData(withNextYear: true)
        ASNetworkService.shared.fetch([Event].self, endpoint: Football.fixtures(from: currentDate, to: nextYearDate)) { [weak self] result in
            DispatchQueue.main.async {
                self?.showLoadingIndicator?(false)
            }
            
            switch result {
            case .success(let upcomingEvents):
                self?.upcomingEvents = upcomingEvents
                DispatchQueue.main.async {
                    self?.render?()
                }
            case .failure(let error):
                self?.errorOccurred?(error.localizedDescription)
            }
        }
    }
    
    func fetchLatestEvents() {
        showLoadingIndicator?(true)
        let (currentDate, lastYear) = getData(withNextYear: false)
        ASNetworkService.shared.fetch([Event].self, endpoint: Football.fixtures(from: lastYear, to: currentDate)) { [weak self] result in
            DispatchQueue.main.async {
                self?.showLoadingIndicator?(false)
            }
            
            switch result {
            case .success(let latestEvents):
                self?.latestEvents = latestEvents
                DispatchQueue.main.async {
                    self?.render?()
                }
            case .failure(let error):
                self?.errorOccurred?(error.localizedDescription)
            }
        }
    }
    
    func fetchLeagueTeams() {
        showLoadingIndicator?(true)
        ASNetworkService.shared.fetch([Team].self, endpoint: Football.teams(leagueID: 152)) { [weak self] result in
            DispatchQueue.main.async {
                self?.showLoadingIndicator?(false)
            }
            switch result {
            case .success(let teams):
                self?.teams = teams
                DispatchQueue.main.async {
                    self?.render?()
                }
            case .failure(let error):
                self?.errorOccurred?(error.localizedDescription)
            }
        }
    }
}
