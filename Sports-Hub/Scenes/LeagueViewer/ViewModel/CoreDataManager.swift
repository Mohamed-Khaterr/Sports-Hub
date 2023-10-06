//
//  Coredata_manager.swift
//  lab2_ios_task2
//
//  Created by Admin on 12/09/2023.
//

import UIKit
import CoreData

class Coredata_manager: NSObject {
    
    static var manager : Coredata_manager = Coredata_manager()
    
    /*
     class Item: Codable {
         var title = ""
         var done = false
     }
     */
    
    func insert_league (league : League) -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let managedContext = appDelegate.persistentContainer.viewContext;
        
        let entity = NSEntityDescription.entity(forEntityName: "Model", in: managedContext)
        
        let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        /*
         class Item: Codable {
             var title = ""
             var done = false
         }
         */
        
        movie.setValue(item.title, forKey: "title");
        movie.setValue(item.done, forKey: "done");

        
        do {
            
            try managedContext.save();
            //print("yk insert")
        } catch let error as NSError {
            print("saving error")
            //print(error);
        }
        
    }
    
    func fetch_from_db() -> Array<Item> {
        
        /*
         class Item: Codable {
             var title = ""
             var done = false
         }
         */
        
        var myItems : Array<Item> = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let managedContext = appDelegate.persistentContainer.viewContext;


        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Model")
        //let myPredicate = NSPredicate (format: "%@", "")
        
        do {
            print("yk fetch")
            var movie = try managedContext.fetch(fetchRequest)

            //print("error here")
            
            
            
            for m in movie {
                var title : String = m.value(forKey: "title") as! String;
                var done : Bool = m.value(forKey: "done") as! Bool;

                var newObj : Item = Item();
                newObj.title = title;
                newObj.done = done;

                myItems.append(newObj);
            }

            print("size = \(movie.count)")
            
            //print(movie)
        } catch let error as NSError {
            print("fetching error")
            //print(error)
        }
        
        return myItems;
    }
    
    func delete_all () -> Void {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            let managedContext = appDelegate.persistentContainer.viewContext;

            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Model")
            //let myPredicate = NSPredicate (format: "%@", "")

            do {
                print("yk fetch")
                var movie = try managedContext.fetch(fetchRequest)

                for i in 0 ..< movie.count {
                    managedContext.delete(movie[i]);
                }

            } catch let error as NSError {
                print("fetch error")
                //print(error)
            }

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("fetch error")
                //print(error)
            }

        }
    
}
