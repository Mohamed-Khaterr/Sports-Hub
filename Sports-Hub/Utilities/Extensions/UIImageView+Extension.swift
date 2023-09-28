//
//  UIImageView+Extension.swift
//  Sports-Hub
//
//  Created by Khater on 28/09/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(withURL url: URL?){
        self.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"))
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
