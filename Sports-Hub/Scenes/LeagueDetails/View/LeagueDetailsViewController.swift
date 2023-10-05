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
    
    // MARK: - Properties
    private let viewModel = LeagueDetailsViewModel()
    private var isFavorite = false
    private var favBarButtonImageName: String {
        return isFavorite ? "heart.fill" : "heart"
    }

    // MARK: LifeCycel
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        bind()
        viewModel.fetchUpcomingEvents()
        viewModel.fetchLatestEvents()
        viewModel.fetchLeagueTeams()
    }
    
    // MARK: - NavigationBar
    private func setupNavigationBar() {
        title = "League Details"
        let favBarButton = UIBarButtonItem(image: UIImage(systemName: favBarButtonImageName), style: .done, target: self, action: #selector(favoriteButtonPressed))
        favBarButton.tintColor = .label
        navigationItem.rightBarButtonItem = favBarButton
    }
    
    // MARK: - Favorite Button
    @objc private func favoriteButtonPressed() {
        isFavorite = !isFavorite
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: favBarButtonImageName)
        
        // TODO: Save to CoreData
    }
    
    
    // MARK: CollectionViewLayout
    private func setupCollectionView() {
        collectionView.register(EventCollectionViewCell.nib(), forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collectionView.register(CVHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CVHeaderView.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionViewLayout()
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0,1: return self.eventSectionLayout(isVertical: (sectionIndex == 1))
            case 2: return self.teamSectionLayout()
            default: return self.teamSectionLayout()
            }
        }
        return layout
    }
    
    private func eventSectionLayout(isVertical: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group: NSCollectionLayoutGroup
        if isVertical {
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        }
        group.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        //header.pinToVisibleBounds = true
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        if !isVertical {
            section.orthogonalScrollingBehavior = .continuous
        }
        
        return section
    }
    
    private func teamSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130), heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // MARK: - Bind
    private func bind() {
        viewModel.render = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.showLoadingIndicator = { [weak self] isLoading in
            print("Loaing: \(isLoading)")
            // TODO: Create Custom Loading Alert
        }
        
        viewModel.errorOccurred = { errorMessage in
            print(errorMessage)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            cell.backgroundColor = .green
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
}
