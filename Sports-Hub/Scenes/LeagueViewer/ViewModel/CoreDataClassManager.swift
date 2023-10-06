//
//  CoreDataClassManager.swift
//  Sports-Hub
//
//  Created by Admin on 06/10/2023.
//

//import Foundation
import CoreData
import UIKit

class CoreDataClassManager: NSObject {
    
    static var manager : CoreDataClassManager = CoreDataClassManager()
    
    func insert_item (item : FavouriteLeague) -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let managedContext = appDelegate.persistentContainer.viewContext;
        
        let entity = NSEntityDescription.entity(forEntityName: "SavedLeague", in: managedContext)
        
        let league = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        league.setValue(item.id, forKey: "id");
        league.setValue(item.sportType, forKey: "sportType");

        
        do {
            
            try managedContext.save();
            //print("yk insert")
        } catch let error as NSError {
            print("saving error")
            //print(error);
        }
        
    }
    
    func fetch_from_db() -> Array<FavouriteLeague> {
        
        /*
         class Item: Codable {
             var title = ""
             var done = false
         }
         */
        
        var myItems : Array<FavouriteLeague> = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let managedContext = appDelegate.persistentContainer.viewContext;


        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedLeague")
        
        do {
            var savedItems = try managedContext.fetch(fetchRequest)
            
            
            
            for l in savedItems {
                var id : Int = l.value(forKey: "id") as! Int;
                var sportType : String = l.value(forKey: "sportType") as! String;

                var newObj : FavouriteLeague = FavouriteLeague();
                newObj.id = id;
                newObj.sportType = sportType;

                myItems.append(newObj);
            }

        } catch let error as NSError {
            print("fetching error")
        }
        
        return myItems;
    }
    
    func findElement (leagueData : FavouriteLeague) -> Bool {
        var arr = fetch_from_db()
        
        for l in arr {
            if l.id == leagueData.id && l.sportType == leagueData.sportType {
                return true;
            }
        }
        
        return false;
    }
    
    func delete_item (leagueData : FavouriteLeague) -> Void {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            let managedContext = appDelegate.persistentContainer.viewContext;

            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedLeague")

            do {
                var leagues = try managedContext.fetch(fetchRequest)

                for i in 0 ..< leagues.count {
                    if leagues[i].value(forKey: "id") as! Int == leagueData.id && leagues[i].value(forKey: "sportType") as! String == leagueData.sportType{
                    managedContext.delete(leagues[i]);
                        
                    }
                }

            } catch let error as NSError {
                print("fetch error")
            }

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("fetch error")
            }

        }
}
