//
//  FavouritesViewModel.swift
//  Sports-Hub
//
//  Created by Admin on 06/10/2023.
//

import Foundation

class FavouritesViewModel : reload_protocol {
    
    var cachedLeagues : [FavouriteLeague] = []
    
    var Table : reload_protocol?
    
    func getCount () -> Int {
        return cachedLeagues.count
    }
    func getID (index : Int) -> Int {
        return cachedLeagues[index].id
    }
    func getSportType (index : Int) -> String {
        return cachedLeagues[index].sportType
    }
    func getLogo (index : Int) -> String {
        return cachedLeagues[index].leagueLogo
    }
    func getName (index : Int) -> String {
        return cachedLeagues[index].leagueName
    }
    
    
    
    func reload_data() {
        
        Table?.reload_data()
    }
    
    func fetchLeaguesFromCoreData () {
        
        cachedLeagues = CoreDataClassManager.manager.fetch_from_db()
        
        
        //reload_data()
    }
    
    init () {
        fetchLeaguesFromCoreData()
    }
}
