//
//  FavouritesViewModel.swift
//  Sports-Hub
//
//  Created by Admin on 06/10/2023.
//

import Foundation

class FavouritesViewModel : reload_protocol {
    
    var favoriteLeages : [League] = []
    var associatedSportType : [String] = []
    
    var Table : reload_protocol?
    
    func getCount () -> Int {
        return favoriteLeages.count
    }
    func getID (index : Int) -> Int {
        return favoriteLeages[index].id
    }
    func getSportType (index : Int) -> String {
        return associatedSportType[index]
    }
    func getLogo (index : Int) -> String {
        return favoriteLeages[index].logoURLString ?? ""
    }
    func getName (index : Int) -> String {
        return favoriteLeages[index].name
    }
    
    
    
    func reload_data() {
        for l in favoriteLeages {
            print(l.name)
        }
        
        Table?.reload_data()
    }
    
    var FootballTableModel = LeaguesTableViewModel()
    var BasketballTableModel = LeaguesTableViewModel()
    var CricketTableModel = LeaguesTableViewModel()
    
    func findFavourites (type : String, model : LeaguesTableViewModel) {
        for i in 0 ..< model.getCount() {
            var id : Int = model.getID(index: i)
            
            var leagueData = FavouriteLeague()
            leagueData.id = id
            leagueData.sportType = type
            
            if CoreDataClassManager.manager.findElement(leagueData: leagueData) {
                favoriteLeages.append (model.getLeague(index: i))
                associatedSportType.append(type)
                
            }
        }
    }
    
    func reloadData () {
        FootballTableModel.Table = self
        BasketballTableModel.Table = self
        CricketTableModel.Table = self
        
        favoriteLeages = []
        associatedSportType = []
        
        var type = ""
        
        type = "Cricket"
        CricketTableModel.setSportType(type)
        CricketTableModel.fetchLeagues()
        
        findFavourites(type: type, model: CricketTableModel)
        
        type = "Basketball"
        BasketballTableModel.setSportType(type)
        BasketballTableModel.fetchLeagues()
        
        findFavourites(type: type, model: BasketballTableModel)
        
        type = "Football"
        
        FootballTableModel.setSportType(type)
        FootballTableModel.fetchLeagues()
        
        findFavourites(type: type, model: FootballTableModel)
        
        
        
    }
    
    init () {
        reloadData()
    }
}
