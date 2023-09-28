//
//  SportsViewController.swift
//  Sports-Hub
//
//  Created by Khater on 28/09/2023.
//

import UIKit

enum CollectionViewAppearance {
    case list
    case grid
}


class SportsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var collectionViewAppearance: CollectionViewAppearance
    
    
    private var viewModel: SportsViewModelProtocol
    
    init(viewModel: SportsViewModelProtocol = SportsViewModel()){
        self.viewModel = viewModel
        self.collectionViewAppearance = .list
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = SportsViewModel()
        self.collectionViewAppearance = .list
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
        let plusBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(plusButtonPressed))
        navigationItem.rightBarButtonItem = plusBarButton
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SportCollectionViewCell.self, forCellWithReuseIdentifier: SportCollectionViewCell.identifier)
        let layout = collectionViewLayout(appearance: collectionViewAppearance)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func collectionViewLayout(appearance: CollectionViewAppearance) -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        let viewWidth = view.frame.width
        let width = (appearance == .list) ? (viewWidth - 36) : viewWidth * 0.46
        flowLayout.itemSize = .init(width: width, height: 100)
        return flowLayout
    }
    
    
    @objc private func plusButtonPressed() {
        collectionViewAppearance = (collectionViewAppearance == .list) ? .grid : .list
        let layout = collectionViewLayout(appearance: collectionViewAppearance)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.didSelectSport = { [weak self] in
            print("DidSelectSport")
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
        print(indexPath)
        viewModel.selectedSport(at: indexPath.item)
    }
}
