//
//  LeagueDetailsViewController.swift
//  Sports-Hub
//
//  Created by Khater on 30/09/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    private lazy var favoriteAnimation = LottieAnimation(animation: "favoriteAnimation", addTo: self.view)
    private lazy var unFavoriteAnimation = LottieAnimation(animation: "unfavoriteAnimation", addTo: self.view)
    
    
    // MARK: - Properties
    let viewModel = LeagueDetailsViewModel()
    private var isFavourite = false

    // MARK: LifeCycel
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.fetchLeague()
        viewModel.fetchUpcomingEvents()
        viewModel.fetchLatestEvents()
        viewModel.fetchLeagueTeams()
        
        setupNavigationBar()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchLeagueFromDB()
    }
    
    // MARK: - NavigationBar
    private func setupNavigationBar() {
        title = "League Details"
        let favBarButton = UIBarButtonItem(image: nil, style: .done, target: self, action: #selector(favoriteButtonPressed))
        favBarButton.tintColor = .label
        navigationItem.rightBarButtonItem = favBarButton
    }
    
    // MARK: - Favorite Button
    @objc private func favoriteButtonPressed() {
        if isFavourite {
            viewModel.removeLeagueFromFavourites()
            unFavoriteAnimation.start()
        } else {
            viewModel.addLeagueToFavourites()
            favoriteAnimation.start()
        }
    }
    
    
    // MARK: CollectionViewLayout
    private func setupCollectionView() {
        collectionView.register(EventCollectionViewCell.nib(), forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
        collectionView.register(CVHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CVHeaderView.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionViewLayout()
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            switch sectionIndex {
            case 0:
                let shrink = self.collectionView.numberOfItems(inSection: sectionIndex) == 0
                return self.eventSectionLayout(withHorizontalScrolling: true, shrink: shrink)
                
            case 1:
                return self.eventSectionLayout()
                
            default:
                return  self.teamSectionLayout()
            }
        }
        return layout
    }
    
    private func eventSectionLayout(withHorizontalScrolling isHorizontalyScrolling: Bool = false, shrink: Bool = false) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group: NSCollectionLayoutGroup
        if isHorizontalyScrolling {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        } else {
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        }
        group.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        //header.pinToVisibleBounds = true
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        if isHorizontalyScrolling && !shrink {
            section.orthogonalScrollingBehavior = .paging
        }
        
        return section
    }
    
    private func teamSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem (layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize (widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.4))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 10)
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in     items.forEach { item in     let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0);     let minScale: CGFloat = 0.8;     let maxScale: CGFloat = 1.0;     let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale);     item.transform = CGAffineTransform(scaleX: scale, y: scale) }}
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // MARK: - Bind
    private func bind() {
        viewModel.render = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.showLoadingIndicator = { [weak self] isLoading in
            if isLoading {
                self?.loadingIndicator.startAnimating()
            } else {
                self?.loadingIndicator.stopAnimating()
            }
        }
        
        viewModel.errorOccurred = { [weak self] errorMessage in
            guard let self = self else { return }
            Alert.show(on: self, title: "Error", message: errorMessage)
        }
        
        viewModel.didSelecteTeam = { [weak self] teamID, sportType in
            let teamVC = TeamViewController()
            teamVC.setTeamID(teamID)
            teamVC.setSportType(sportType)
            self?.navigationController?.pushViewController(teamVC, animated: true)
        }
        
        viewModel.isFavouriteLeague = { [weak self] isFavourite in
            self?.isFavourite = isFavourite
            let imageName = isFavourite ? "heart.fill" : "heart"
            self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
            self?.navigationItem.rightBarButtonItem?.tintColor = isFavourite ? .red : .label
        }
        
        viewModel.updateNavigationTitle = { [weak self] title in
            self?.title = title
        }
    }
}



// MARK: - UICollectionView Delegate & DataSource
extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.noOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.noOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! CollectionViewCell
            viewModel.configTeamCell(cell, atIndex: indexPath.row)
            
            cell.team_image.layer.borderWidth = 1
            cell.team_image.layer.masksToBounds = false
            cell.team_image.layer.borderColor = UIColor.black.cgColor
            
            let mx = max (cell.team_image.frame.width, cell.team_image.frame.height)
            cell.team_image.layer.cornerRadius = (mx / 2) - 5
            
            cell.team_image.clipsToBounds = true
            cell.team_image.backgroundColor = .white
            
            
            //here
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
            viewModel.configEventCell(cell, atIndex: indexPath.item, andSection: indexPath.section)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CVHeaderView.identifier, for: indexPath) as! CVHeaderView
        viewModel.configHeaderView(header, atSection: indexPath.section)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.item, section: indexPath.section)
    }
}
