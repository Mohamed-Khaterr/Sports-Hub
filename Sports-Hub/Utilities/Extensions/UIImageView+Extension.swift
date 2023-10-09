//
//  UIImageView+Extension.swift
//  Sports-Hub
//
//  Created by Khater on 28/09/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(withURL url: URL?, defaultImage: String? = nil){
        self.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage")) { [weak self] result in
            switch result {
            case .success(_): return
            case .failure(_):
                if let defaultImage = defaultImage {
                    self?.image = UIImage(named: defaultImage)
                }
            }
        }
        /*
        let selectedContentMode = self.contentMode
        let selectedBackgroundColor = self.backgroundColor
        self.contentMode = .scaleAspectFit
        self.backgroundColor = .white
        self.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage")) { [weak self] _ in
            self?.contentMode = selectedContentMode
            self?.backgroundColor = selectedBackgroundColor
            UIView.animate(withDuration: 0.5) {
                self?.alpha = 0
                
            } completion: { _ in
                UIView.animate(withDuration: 2.5) {
                    self?.alpha = 1
                }
            }
        }
        */
    }
}
