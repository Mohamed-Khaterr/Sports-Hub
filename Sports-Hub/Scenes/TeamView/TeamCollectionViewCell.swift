//
//  TeamCollectionViewCell.swift
//  movieApp
//
//  Created by Admin on 01/10/2023.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var player_image: UIImageView!
    
    @IBOutlet weak var player_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        player_name.text = "Messi"
        player_image.image = UIImage(named: "premiere_league_logo");
        
        // Initialization code
    }

}
