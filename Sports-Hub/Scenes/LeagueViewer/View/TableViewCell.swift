//
//  TableViewCell.swift
//  Sports-Hub
//
//  Created by Admin on 28/09/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    var is_favourite = false;
    
    var leagueData : FavouriteLeague = FavouriteLeague()
    
    var delegate : FavouritesTableVC?

    @IBOutlet weak var league_image: UIImageView!


    @IBOutlet weak var favourite: UIImageView!
    
    
    @IBOutlet weak var LeagueName: UILabel!
    
    
    func isLeagueInFavourites () -> Bool {
        return CoreDataClassManager.manager.findElement(leagueData: leagueData);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap_on_image));

        favourite.addGestureRecognizer(tapGesture)
        favourite.isUserInteractionEnabled = true
        
        set_favourite_image()
        
        //var mx = max(league_image.frame.width, league_image.frame.height)
        
        //var radius : Float = Float(mx / 2.0);
        
        league_image.layer.borderWidth = 1
        league_image.layer.masksToBounds = false
        league_image.layer.borderColor = UIColor.black.cgColor
        league_image.layer.cornerRadius = max(league_image.frame.width, league_image.frame.height) / 2
        league_image.layer.cornerRadius = 20
        league_image.clipsToBounds = true
        league_image.backgroundColor = .black

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set_favourite_image() {
        if isLeagueInFavourites() {
            favourite.image = UIImage(systemName: "suit.heart.fill")
        }
        else {
            favourite.image = UIImage(systemName: "suit.heart");
        }
    }

    @objc func tap_on_image () {
        if isLeagueInFavourites() {
            CoreDataClassManager.manager.delete_item(leagueData: leagueData)
        }
        else {
            CoreDataClassManager.manager.insert_item(item: leagueData)
        }
        set_favourite_image()
        
        if delegate != nil {
            delegate?.reset_view()
        }
    }



}
