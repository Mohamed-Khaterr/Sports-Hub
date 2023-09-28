//
//  SportCollectionViewCell.swift
//  Sports-Hub
//
//  Created by Khater on 28/09/2023.
//

import UIKit
import Kingfisher


protocol SportCellView: AnyObject {
    func setBackgroundImageView(withURL url: URL?)
    func setBackgroundImageView(withName name: String)
    func setTitleLabel(withText text: String)
}


class SportCollectionViewCell: UICollectionViewCell {
    static let identifier = "SportCollectionViewCell"
    
    
    // MARK: Elements
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    
    private let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }
    
    
    // MARK: SubViews
    private func setupSubViews() {
        [backgroundImageView, titleLabel].forEach({ self.addSubview($0) })
        backgroundImageView.addSubview(overlayView)
        
        // Constraints
        setupBackgroundImageViewConstraints()
        setupOverlayViewConstraints()
        setupTitleLabelConstraints()
    }
    
    
    // MARK: Constraints
    private func setupBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func setupOverlayViewConstraints() {
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}



// MARK: - SportCellView
extension SportCollectionViewCell: SportCellView {
    func setBackgroundImageView(withName name: String) {
        backgroundImageView.image = UIImage(named: name)
    }
    
    func setBackgroundImageView(withURL url: URL?) {
        backgroundImageView.setImage(withURL: url)
    }
    
    func setTitleLabel(withText text: String) {
        titleLabel.text = text
    }
}
