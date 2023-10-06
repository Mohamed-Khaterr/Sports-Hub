//
//  EventCollectionViewCell.swift
//  Sports-Hub
//
//  Created by Khater on 27/09/2023.
//

import UIKit
import Kingfisher


class EventCollectionViewCell: UICollectionViewCell {
    static let identifier = "EventCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "EventCollectionViewCell", bundle: nil)
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    private func addGradientToContainerView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = containerView.bounds
        gradientLayer.colors = [
            UIColor(named: "RedPurple")!.cgColor,
            UIColor(named: "DarkPurple")!.cgColor
        ]
        gradientLayer.locations = [0, 0.25]
        containerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addShadowToCell() {
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}


extension EventCollectionViewCell: EventCellView {
    func setupCellUI() {
        
        leagueImageView.layer.cornerRadius = 10
        
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        addGradientToContainerView()
        addShadowToCell()
        
        [homeTeamNameLabel, awayTeamLabel, scoreLabel, timeLabel, dateLabel].forEach({ $0?.textColor = .white })
    }
    
    func setLeagueImage(withURL url: URL?, defaultImage: String?) {
        leagueImageView.setImage(withURL: url, defaultImage: defaultImage)
    }
    
    func setHomeTeamImage(withURL url: URL?, defaultImage: String?) {
        homeTeamImageView.setImage(withURL: url, defaultImage: defaultImage)
    }
    func setAwayTeamImage(withURL url: URL?, defaultImage: String?) {
        awayTeamImageView.setImage(withURL: url, defaultImage: defaultImage)
    }
    
    func setNames(homeTeam: String, awayTeam: String) {
        homeTeamNameLabel.text = homeTeam
        awayTeamLabel.text = awayTeam
    }
    
    func setScore(_ score: String) {
        scoreLabel.text = score
    }
    
    func setTime(_ time: String) {
        timeLabel.text = time
    }
    
    func setDate(_ date: String) {
        dateLabel.text = date
    }
    
    func hideScore() {
        scoreLabel.isHidden = true
    }
}
