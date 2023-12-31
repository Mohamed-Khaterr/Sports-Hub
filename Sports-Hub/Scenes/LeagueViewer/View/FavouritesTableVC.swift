//
//  FavouritesTableVC.swift
//  Sports-Hub
//
//  Created by Admin on 06/10/2023.
//

import UIKit
import Lottie

class FavouritesTableVC: UITableViewController, reload_protocol {
    
    let animationView = LottieAnimationView(name: "No_Data")
    
    func reload_data() {
        tableView.reloadData()
    }
    
    func reset_view () {
        favouritesViewModel.reload_data()
    }
    
    var favouritesViewModel = FavouritesViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "test")
        
        
        favouritesViewModel.Table = self
        
        reset_view()
        
        title = "Favourites"
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleToFill

        tableView.addSubview(animationView)


        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])

        animationView.loopMode = .loop
        animationView.play()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouritesViewModel.fetchLeaguesFromCoreData()
        reset_view()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var cnt = favouritesViewModel.getCount()
        
        animationView.isHidden = cnt > 0
        if !animationView.isHidden {
            animationView.play()
        }
        
        return cnt
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "test") as! TableViewCell;

        
        
        cell.leagueData.id = favouritesViewModel.getID(index: indexPath.item)
        cell.leagueData.sportType = favouritesViewModel.getSportType(index: indexPath.item);
        
        cell.league_image.setImage(withURL: URL(string: favouritesViewModel.getLogo(index: indexPath.item)))
        cell.LeagueName.text = favouritesViewModel.getName(index: indexPath.item)
        
        cell.delegate = self
        
        cell.set_favourite_image()
        cell.favourite.isHidden = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if InternetMointor.shared.isConnected {
            let vc = LeagueDetailsViewController()
            vc.viewModel.setLeague(id: favouritesViewModel.getID(index: indexPath.row))
            switch favouritesViewModel.getSportType(index: indexPath.row) {
            case "Football": vc.viewModel.setSportType(.football)
            case "Basketball": vc.viewModel.setSportType(.basketball)
            case "Cricket": vc.viewModel.setSportType(.cricket)
            default: return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            Alert.show(on: self, title: "Connnection", message: "No internet connection available, Please check your internet connection")
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                let league = FavouriteLeague()
                league.id = self.favouritesViewModel.getID(index: indexPath.row)
                league.leagueName = self.favouritesViewModel.getName(index: indexPath.row)
                league.leagueLogo = self.favouritesViewModel.getLogo(index: indexPath.row)
                league.sportType = self.favouritesViewModel.getSportType(index: indexPath.row)
                CoreDataClassManager.manager.delete_item(leagueData: league)
                self.favouritesViewModel.fetchLeaguesFromCoreData()
                tableView.deleteRows(at: [indexPath], with: .left)
            }
            
            Alert.show(on: self, title: "Delete League", message: "Are you sure that you want to delete league from Favourites", actions: [cancelAction, deleteAction])
        }
    }
    

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
