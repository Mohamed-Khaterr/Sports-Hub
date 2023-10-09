//
//  LeagueDetailsViewModel.swift
//  Sports-Hub
//
//  Created by Khater on 30/09/2023.
//

import Foundation


class LeagueDetailsViewModel {
    private var league: League?
    private var leagueID = 0
    private var sportType: SportType = .football
    
    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event] = []
    private var teams: [Team] = []
    
    private var dataDownloaded: [Int: Bool] = [:] {
        didSet {
            if dataDownloaded.allSatisfy({ $0.value }) {
                // All True
                DispatchQueue.main.async {
                    self.showLoadingIndicator?(false)
                }
            } else {
                // Contains false
                self.showLoadingIndicator?(true)
            }
        }
    }
    
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
    var isFavouriteLeague: ((Bool) -> Void)?
    var updateNavigationTitle: ((String) -> Void)?
    
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
//            cell.hideScore()
            cell.setScore(event.result ?? event.status)
            cell.setDate(event.date ?? "")
            cell.setTime(event.time)
            cell.setNames(homeTeam: event.homeTeamName, awayTeam: event.awayTeamName)
            cell.setLeagueImage(withURL: URL(string: event.leagueLogoURLString ?? ""), defaultImage: nil)
            cell.setHomeTeamImage(withURL: URL(string: event.homeTeamLogoURLString ?? ""), defaultImage: defaultTeamImageName)
            cell.setAwayTeamImage(withURL: URL(string: event.awayTeamLogoURLString ?? ""), defaultImage: defaultTeamImageName)
        case 1:
            let event = latestEvents[index]
            cell.setupCellUI()
            cell.setScore(event.result ?? event.status)
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
    
    private func getDateStringInYear(byAddingYear year: Int = 0) -> String {
        // API Error: The difference between to and from cannot be greater than 15 days if there is no other parameter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let lastDay = Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!
        let date = Calendar.current.date(byAdding: .year, value: year, to: lastDay)!
        return formatter.string(from: date)
    }
    
    private func getDateStringInDay(byAddingDay day: Int = 0) -> String {
        // API Error: The difference between to and from cannot be greater than 15 days if there is no other parameter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = Calendar.current.date(byAdding: .day, value: day, to: Date.now)!
        return formatter.string(from: date)
    }
    
    
    // MARK: - Upcoming Events
    func fetchUpcomingEvents() {
        dataDownloaded[0] = false
        let currentDate = getDateStringInYear()
        let nextYear = getDateStringInYear(byAddingYear: 1)
        let nextDays = getDateStringInDay(byAddingDay: 15)
        
        ASNetworkService.shared.fetch([Event].self, sport: sportType, endpoint: .events(from: currentDate, to: nextDays, leagueID: leagueID)) { [weak self] result in
            self?.dataDownloaded[0] = true
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
    func fetchLatestEvents() {
        dataDownloaded[1] = false
        let currentDate = getDateStringInYear()
        let lastYear = getDateStringInYear(byAddingYear: -1)
        let lastDays = getDateStringInDay(byAddingDay: -15)
        ASNetworkService.shared.fetch([Event].self, sport: sportType, endpoint: .events(from: lastDays, to: currentDate, leagueID: leagueID)) { [weak self] result in
            self?.dataDownloaded[1] = true
            
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
    func fetchLeagueTeams() {
        dataDownloaded[2] = false
        ASNetworkService.shared.fetch([Team].self, sport: sportType, endpoint: .teams(leagueID: leagueID)) { [weak self] result in
            self?.dataDownloaded[2] = true
            
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
    
    // MARK: - League
    func fetchLeague() {
        ASNetworkService.shared.fetch([League].self, sport: sportType, endpoint: .leagues) { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.league = leagues.filter { $0.id == self?.leagueID }.first
                self?.updateNavigationTitle?(self?.league?.name ?? "League Details")
                self?.fetchLeagueFromDB()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchLeagueFromDB() {
        guard let leagueDB = getLeagueDB() else { return }
        let isFavourite = CoreDataClassManager.manager.findElement(leagueData: leagueDB)
        self.isFavouriteLeague?(isFavourite)
    }
    
    private func getLeagueDB() -> FavouriteLeague? {
        guard let league = league else { return nil }
        let leagueDB = FavouriteLeague()
        leagueDB.id = leagueID
        leagueDB.sportType = sportType.rawValue
        leagueDB.leagueName = league.name
        leagueDB.leagueLogo = league.logoURLString ?? ""
        return leagueDB
    }
    
    func addLeagueToFavourites() {
        guard let leagueDB = getLeagueDB() else { return }
        let isFavourite = CoreDataClassManager.manager.findElement(leagueData: leagueDB)
        if !isFavourite {
            CoreDataClassManager.manager.insert_item(item: leagueDB)
            self.isFavouriteLeague?(true)
        }
    }
    
    func removeLeagueFromFavourites() {
        guard let leagueDB = getLeagueDB() else { return }
        let isFavourite = CoreDataClassManager.manager.findElement(leagueData: leagueDB)
        if isFavourite {
            CoreDataClassManager.manager.delete_item(leagueData: leagueDB)
            self.isFavouriteLeague?(false)
        }
    }
}
