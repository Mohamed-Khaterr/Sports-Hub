//
//  TeamViewModel.swift
//  Sports-Hub
//
//  Created by Admin on 05/10/2023.
//

import Foundation

class TeamViewModel {

    var TeamID : Int = 80
    private var team : Team?
    
    var viewer : reload_protocol?;
    
    var teamViewControllerInstance : reload_protocol?
    
    private var SportType : String = "Football"
    
    var showLoadingIndicator: ((Bool) -> Void)?
    var render: (() -> Void)?
    var errorOccurred: ((String) -> Void)?
    
    func setSportType(_ type: String) {
        self.SportType = type
    }
    
    func getName () -> String{
        return team?.name ?? "Not Found"
    }
    func getID (index : Int) -> Int{
        return team?.id ?? -1
    }
    
    func getPlayersCount () -> Int{
        return team?.players?.count ?? 0
    }
    
    func getPlayerName (index : Int) -> String {
        team?.players?[index].name ?? "Name Not Found";
    }
    func getPlayerImage (index : Int) -> String? {
        team?.players?[index].imageURLString;
    }
    

    func getLogo () -> String {
        return team?.logoURLString ?? "Not Found"
    }
    
    init () {
        
    }
    
    func fetchTeam() {
        if (SportType == "Football") {

            showLoadingIndicator?(true)
            ASNetworkService.shared.fetch([Team].self, endpoint: Football.team(id: TeamID)) { [weak self] result in
                DispatchQueue.main.async {
                    self?.showLoadingIndicator?(false)
                }
                switch result {
                case .success(let team):
                    //print("trace : \(team[0].name)")
                    self?.team = team[0]
                    //self?.viewer?.reload_data()
                    DispatchQueue.main.async {
                        self?.render?()
                        self?.viewer?.reload_data()
                    }
                case .failure(let error):
                    self?.errorOccurred?(error.localizedDescription)
                }
            }
            
        }
        else if (SportType == "Basketball") {
            showLoadingIndicator?(true)
            ASNetworkService.shared.fetch([Team].self, endpoint: Basketball.team(id: TeamID)) { [weak self] result in
                DispatchQueue.main.async {
                    self?.showLoadingIndicator?(false)
                }
                switch result {
                case .success(let team):
                    //print("trace : \(team[0].name)")
                    self?.team = team[0]
                    //self?.viewer?.reload_data()
                    DispatchQueue.main.async {
                        self?.render?()
                        self?.viewer?.reload_data()
                    }
                case .failure(let error):
                    self?.errorOccurred?(error.localizedDescription)
                }
            }
        }
        else if (SportType == "Cricket") {
            showLoadingIndicator?(true)
            ASNetworkService.shared.fetch([Team].self, endpoint: Cricket.team(id: TeamID)) { [weak self] result in
                DispatchQueue.main.async {
                    self?.showLoadingIndicator?(false)
                }
                switch result {
                case .success(let team):
                    //print("trace : \(team[0].name)")
                    self?.team = team[0]
                    //self?.viewer?.reload_data()
                    DispatchQueue.main.async {
                        self?.render?()
                        self?.viewer?.reload_data()
                    }
                case .failure(let error):
                    self?.errorOccurred?(error.localizedDescription)
                }
            }
        }
        else if (SportType == "Tennis") {
            
        }
    }
}
