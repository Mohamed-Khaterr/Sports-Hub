//
//  LeagueDetailsViewModel.swift
//  Sports-Hub
//
//  Created by Khater on 30/09/2023.
//

import Foundation


class LeagueDetailsViewModel {
    private var leagueID = 0
    private var sportType: SportType = .football
    
    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event] = []
    private var teams: [Team] = []
    
    func setLeague(id: Int) {
        leagueID = id
    }
    
    func setSportType(_ type: SportType) {
        sportType = type
    }
    
    var showLoadingIndicator: ((Bool) -> Void)?
    var render: (() -> Void)?
    var errorOccurred: ((String) -> Void)?
    var didSelecteTeam: ((Int, SportType) -> Void)?
    
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
        let defaultTeamImageName: String
        switch sportType {
        case .football: defaultTeamImageName = Constant.footballImageName
        case .basketball: defaultTeamImageName = Constant.basketballImageName
        case .cricket: defaultTeamImageName = Constant.cricketImageName
        }
        
        switch section {
        case 0:
            let event = upcomingEvents[index]
            cell.setupCellUI()
            cell.hideScore()
            cell.setDate(event.date ?? "")
            cell.setTime(event.time)
            cell.setNames(homeTeam: event.homeTeamName, awayTeam: event.awayTeamName)
            cell.setLeagueImage(withURL: URL(string: event.leagueLogoURLString ?? ""), defaultImage: nil)
            cell.setHomeTeamImage(withURL: URL(string: event.homeTeamLogoURLString ?? ""), defaultImage: defaultTeamImageName)
            cell.setAwayTeamImage(withURL: URL(string: event.awayTeamLogoURLString ?? ""), defaultImage: defaultTeamImageName)
        case 1:
            let event = latestEvents[index]
            cell.setupCellUI()
            cell.setScore(event.result ?? "")
            cell.setDate(event.date ?? "")
            cell.setTime(event.time)
            cell.setNames(homeTeam: event.homeTeamName, awayTeam: event.awayTeamName)
            cell.setLeagueImage(withURL: URL(string: event.leagueLogoURLString ?? ""), defaultImage: nil)
            cell.setHomeTeamImage(withURL: URL(string: event.homeTeamLogoURLString ?? ""), defaultImage: defaultTeamImageName)
            cell.setAwayTeamImage(withURL: URL(string: event.awayTeamLogoURLString ?? ""), defaultImage: defaultTeamImageName)
        default: return
        }
    }
    
    func configTeamCell(_ cell: CollectionViewCell, atIndex index: Int) {
        let team = teams[index]
        cell.team_image.setImage(withURL: URL(string: team.logoURLString ?? ""))
        cell.team_label.text = team.name
    }
    
    func didSelectItem(at index: Int, section: Int) {
        guard section == 2 else { return }
        let team = teams[index]
        didSelecteTeam?(team.id, sportType)
    }
    
    private func getDateString(byAddingDays days: Int = 1) -> String {
        // API Error: The difference between to and from cannot be greater than 15 days if there is no other parameter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = Calendar.current.date(byAdding: .day, value: days, to: Date())!
        return formatter.string(from: date)
    }
    
    
    // MARK: - Upcoming Events
    private func getEndPointForUpcomintEvents() -> ASEndPoint {
        let currentDate = getDateString()
        let nextDate = getDateString(byAddingDays: 15)
        switch sportType {
        case .football: return Football.fixtures(from: currentDate, to: nextDate, leagueID: leagueID)
        case .basketball: return Basketball.events(from: currentDate, to: nextDate, leagueID: leagueID)
        case .cricket: return Cricket.events(from: currentDate, to: nextDate, leagueID: leagueID)
        }
    }
    
    func fetchUpcomingEvents() {
        showLoadingIndicator?(true)
        ASNetworkService.shared.fetch([Event].self, endpoint: getEndPointForUpcomintEvents()) { [weak self] result in
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
    
    
    // MARK: - Latest Events
    private func getEndPointForLatestEvents() -> ASEndPoint {
        let currentDate = getDateString()
        let lastDate = getDateString(byAddingDays: -15)
        switch sportType {
        case .football: return Football.fixtures(from: lastDate, to: currentDate, leagueID: leagueID)
        case .basketball: return Basketball.events(from: lastDate, to: currentDate, leagueID: leagueID)
        case .cricket: return Cricket.events(from: lastDate, to: currentDate, leagueID: leagueID)
        }
    }
    
    func fetchLatestEvents() {
        showLoadingIndicator?(true)
        ASNetworkService.shared.fetch([Event].self, endpoint: getEndPointForLatestEvents()) { [weak self] result in
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
    
    
    // MARK: - League Teams
    private func getEndPointForLeagueTeams(leagueID: Int) -> ASEndPoint {
        switch sportType {
        case .football: return Football.teams(leagueID: leagueID)
        case .basketball: return Basketball.teams(leagueID: leagueID)
        case .cricket: return Cricket.teams(leagueID: leagueID)
        }
    }
    
    func fetchLeagueTeams() {
        showLoadingIndicator?(true)
        ASNetworkService.shared.fetch([Team].self, endpoint: getEndPointForLeagueTeams(leagueID: self.leagueID)) { [weak self] result in
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
