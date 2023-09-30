//
//  CVHeaderView.swift
//  Sports-Hub
//
//  Created by Khater on 30/09/2023.
//

import UIKit


protocol CVHeaderViewProtocol: AnyObject {
    func configure()
    func setTitle(_ text: String)
}


class CVHeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private func setupConstraints() {
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18)
        ])
    }
}



// MARK: - CVHeaderViewProtocol
extension CVHeaderView: CVHeaderViewProtocol {
    func configure() {
        setupConstraints()
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}
