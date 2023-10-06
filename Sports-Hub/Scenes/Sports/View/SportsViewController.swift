//
//  SportsViewController.swift
//  Sports-Hub
//
//  Created by Khater on 28/09/2023.
//

import UIKit

enum CVAppearance {
    case list
    case grid
    
    var image: UIImage? {
        switch self {
        case .list: return UIImage(systemName: "square.grid.2x2.fill")
        case .grid: return UIImage(systemName: "rectangle.grid.1x2.fill")
        }
    }
}


class SportsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var cvAppearance: CVAppearance = .list
    private var apperanceBarButton: UIBarButtonItem?
    
    private var viewModel: SportsViewModelProtocol
    
    init(viewModel: SportsViewModelProtocol = SportsViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = SportsViewModel()
        super.init(coder: coder)
        bindViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }
    
    
    
    private func setupNavigationBar() {
        title = "Sports"
        apperanceBarButton = UIBarButtonItem(image: cvAppearance.image,
                                             style: .plain,
                                             target: self,
                                             action: #selector(appearanceBarButtonPressed))
        
        navigationItem.rightBarButtonItem = apperanceBarButton
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SportCollectionViewCell.self, forCellWithReuseIdentifier: SportCollectionViewCell.identifier)
        let layout = collectionViewLayout(appearance: cvAppearance)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func collectionViewLayout(appearance: CVAppearance) -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        let viewWidth = view.frame.width
        let width = (appearance == .list) ? (viewWidth - 36) : viewWidth * 0.46
        flowLayout.itemSize = .init(width: width, height: 100)
        return flowLayout
    }
    
    
    @objc private func appearanceBarButtonPressed() {
        cvAppearance = (cvAppearance == .list) ? .grid : .list
        let layout = collectionViewLayout(appearance: cvAppearance)
        collectionView.setCollectionViewLayout(layout, animated: true)
        apperanceBarButton?.image = cvAppearance.image
    }
    
    private func bindViewModel() {
        viewModel.didSelectSport = { [weak self] sportType in
            let leagueViewer = TableView_XIB()
            leagueViewer.setSportType(sportType)
            self?.navigationController?.pushViewController(leagueViewer, animated: true)
//            let leagueDetailsVC = LeagueDetailsViewController()
//            leagueDetailsVC.viewModel.setSportType(sportType)
//            self?.navigationController?.pushViewController(leagueDetailsVC, animated: true)
        }
    }
}


// MARK: - UICollectionView Delegate & DataSource
extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.noOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportCollectionViewCell.identifier, for: indexPath) as! SportCollectionViewCell
        viewModel.configuarCell(cell, at: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedSport(at: indexPath.item)
    }
}
