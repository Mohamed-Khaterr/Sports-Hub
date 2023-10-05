//
//  CollectionViewCell.swift
//  movieApp
//
//  Created by Admin on 29/09/2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var team_image: UIImageView!
    
    @IBOutlet weak var background_grey: UIImageView!
    
    
    @IBOutlet weak var team_label: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        team_image.image = UIImage(named: "premiere_league_logo");
        background_grey.layer.cornerRadius = 10;
        
        team_label.text = "Madrid"

    }

}
