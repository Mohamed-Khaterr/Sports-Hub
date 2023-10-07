//
//  TeamViewController.swift
//  movieApp
//
//  Created by Admin on 01/10/2023.
//

import UIKit

class TeamViewController:
    UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, reload_protocol {
    
    var teamModel : TeamViewModel = TeamViewModel()
    
    func reload_data() {
        self.team_name.text = teamModel.getName()
        self.stadium_name.text = ""
        self.team_image.setImage(withURL: URL(string: teamModel.getLogo()))
        self.players_collection_view.reloadData()
        
        print("size : \(teamModel.getPlayersCount())")
    }
    
    func setTeamID(_ id: Int) {
        teamModel.TeamID = id
    }
    
    func setSportType(_ type: SportType) {
        teamModel.setSportType(type.rawValue)
    }
    
    @IBOutlet weak var stadium_image: UIImageView!
    
    
    @IBOutlet weak var team_image: UIImageView!
    
    
    @IBOutlet weak var team_name: UILabel!
    
    @IBOutlet weak var stadium_name: UILabel!
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teamModel.getPlayersCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Team_collection_cell", for: indexPath) as! TeamCollectionViewCell;
        
        var url = teamModel.getPlayerImage(index: indexPath.item);
        cell.player_image.setImage(withURL: URL(string: url ?? ""),  defaultImage: "player_placeholder")
        
        var name = teamModel.getPlayerName(index: indexPath.item)
        
        cell.player_name.text = name
        
        
        return cell;
        
    }
    
    @IBOutlet weak var players_collection_view: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.players_collection_view.delegate = self;
        self.players_collection_view.dataSource = self
        self.players_collection_view.backgroundColor = UIColor.clear.withAlphaComponent(0)

        
        self.stadium_image.setImage(withURL: URL(string: "https://www.pixelstalk.net/wp-content/uploads/2016/11/Awesome-Camp-Nou-Background.jpg"))
        
        
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = stadium_image.bounds

        gradientMaskLayer.colors =  [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0.05, 0.5, 0.95]

        stadium_image.layer.mask = gradientMaskLayer
        
        self.stadium_image.alpha = 0.6
        
        self.stadium_name.text = "C_stadium_name"
        self.team_name.text = "C_team_name"
        self.team_name.alpha = 1
        
        let layout_ = UICollectionViewCompositionalLayout { index, env in

            let itemSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem (layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(300))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 10)
            
            section.orthogonalScrollingBehavior = .continuous
            
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in     items.forEach { item in     let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0);     let minScale: CGFloat = 0.8;     let maxScale: CGFloat = 1.0;     let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale);     item.transform = CGAffineTransform(scaleX: scale, y: scale)     }}
            
            return section

        }
        
        self.players_collection_view.setCollectionViewLayout(layout_, animated: true)
        
        self.players_collection_view.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Team_collection_cell")
        
        teamModel.viewer = self;
        
        teamModel.fetchTeam()

        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated : Bool) {
//        //super.viewDidAppear(Bool)
//        viewDidLoad()
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
