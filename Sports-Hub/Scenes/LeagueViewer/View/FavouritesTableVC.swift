//
//  FavouritesTableVC.swift
//  Sports-Hub
//
//  Created by Admin on 06/10/2023.
//

import UIKit

class FavouritesTableVC: UITableViewController, reload_protocol {
    func reload_data() {
        tableView.reloadData()
    }
    
    func reset_view () {
        favouritesViewModel.reloadData()
    }
    
    var favouritesViewModel = FavouritesViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "test")
        
        tableView.backgroundColor = .red
        
        
        favouritesViewModel.Table = self
        
        reset_view()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reset_view()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favouritesViewModel.getCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "test") as! TableViewCell;

        
        
        cell.leagueData.id = favouritesViewModel.getID(index: indexPath.item)
        cell.leagueData.sportType = favouritesViewModel.getSportType(index: indexPath.item);
        
        cell.league_image.setImage(withURL: URL(string: favouritesViewModel.getLogo(index: indexPath.item)))
        cell.LeagueName.text = favouritesViewModel.getName(index: indexPath.item)
        
        cell.delegate = self
        
        cell.set_favourite_image()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = LeagueDetailsViewController()
        vc.viewModel.setLeague(id: favouritesViewModel.getID(index: indexPath.row))
        switch favouritesViewModel.getSportType(index: indexPath.row) {
        case "Football": vc.viewModel.setSportType(.football)
        case "Basketball": vc.viewModel.setSportType(.basketball)
        case "Cricket": vc.viewModel.setSportType(.cricket)
        default: return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
