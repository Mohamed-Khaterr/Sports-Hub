//
//  TableViewCell.swift
//  Sports-Hub
//
//  Created by Admin on 28/09/2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var league_image: UIImageView!


    @IBOutlet weak var youtube_link: UIImageView!
    
    
    @IBOutlet weak var LeagueName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap_on_image));

        youtube_link.addGestureRecognizer(tapGesture)
        youtube_link.isUserInteractionEnabled = true

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func tap_on_image () {
        print("youtube.com")
    }



}
