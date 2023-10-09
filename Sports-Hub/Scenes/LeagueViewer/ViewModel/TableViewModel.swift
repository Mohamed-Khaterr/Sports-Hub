//
//  TableViewModel.swift
//  Sports-Hub
//
//  Created by Admin on 05/10/2023.
//

import Foundation

class LeaguesTableViewModel {
    private var leagues : [League] = []
    
    var Table : reload_protocol?
    
    private var SportType : String = "xxx"
    
    func setSportType(_ type: String) {
        self.SportType = type
    }
    
    var showLoadingIndicator: ((Bool) -> Void)?
    var render: (() -> Void)?
    var errorOccurred: ((String) -> Void)?
    
    func getCount () -> Int {
        return leagues.count;
    }
    
    func getName (index : Int) -> String{
        return leagues[index].name
    }
    func getID (index : Int) -> Int{
        return leagues[index].id
    }
    func getLeague (index : Int) -> League {
        return leagues[index]
    }
    
    
    func getLogo (index : Int) -> String {
        return leagues[index].logoURLString ?? ""
    }
    

    func fetchLeagues() {
        if (SportType == "Football") {

            showLoadingIndicator?(true)
            ASNetworkService.shared.fetch([League].self, endpoint: Football.leagues()) { [weak self] result in
                DispatchQueue.main.async {
                    self?.showLoadingIndicator?(false)
                }
                switch result {
                case .success(let leagues):
                    print("trace : \(leagues.count)")
                    self?.leagues = leagues
                    self?.Table?.reload_data()
                    DispatchQueue.main.async {
                        self?.render?()
                    }
                case .failure(let error):
                    self?.errorOccurred?(error.localizedDescription)
                }
            }
            
        }
        else if (SportType == "Basketball") {
            showLoadingIndicator?(true)
            ASNetworkService.shared.fetch([League].self, endpoint: Basketball.leagues) { [weak self] result in
                DispatchQueue.main.async {
                    self?.showLoadingIndicator?(false)
                }
                switch result {
                case .success(let leagues):
                    print("trace : \(leagues.count)")
                    self?.leagues = leagues
                    self?.Table?.reload_data()
                    DispatchQueue.main.async {
                        self?.render?()
                    }
                case .failure(let error):
                    self?.errorOccurred?(error.localizedDescription)
                }
            }
            
        }
        else if (SportType == "Cricket") {
            showLoadingIndicator?(true)
            ASNetworkService.shared.fetch([League].self, endpoint: Cricket.leagues) { [weak self] result in
                DispatchQueue.main.async {
                    self?.showLoadingIndicator?(false)
                }
                switch result {
                case .success(let leagues):
                    print("trace : \(leagues.count)")
                    self?.leagues = leagues
                    self?.Table?.reload_data()
                    DispatchQueue.main.async {
                        self?.render?()
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
