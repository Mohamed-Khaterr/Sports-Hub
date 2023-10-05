//
//  TeamViewController.swift
//  movieApp
//
//  Created by Admin on 01/10/2023.
//

import UIKit

class TeamViewController:
    UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var stadium_image: UIImageView!
    
    
    @IBOutlet weak var team_image: UIImageView!
    
    
    @IBOutlet weak var team_name: UILabel!
    
    @IBOutlet weak var stadium_name: UILabel!
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Team_collection_cell", for: indexPath) as! TeamCollectionViewCell;
        
        return cell;
        
    }
    
    @IBOutlet weak var players_collection_view: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.players_collection_view.delegate = self;
        self.players_collection_view.dataSource = self
        
        self.team_image.backgroundColor = .blue
        self.stadium_image.backgroundColor = .cyan
        
        self.stadium_name.text = "C_stadium_name"
        self.team_name.text = "C_team_name"
        
        let layout_ = UICollectionViewCompositionalLayout { index, env in

            let itemSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem (layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(255))
            
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

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
