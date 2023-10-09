//
//  LottieAnimation.swift
//  Sports-Hub
//
//  Created by Khater on 08/10/2023.
//

import UIKit
import Lottie


class LottieAnimation {
    private let superView: UIView
    private let lottieAnimationView: LottieAnimationView
    
    init(animation name: String, addTo view: UIView) {
        self.lottieAnimationView = .init(name: name)
        self.superView = view
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .playOnce
    }
    
    private func addToSuperView() {
        superView.addSubview(lottieAnimationView)
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lottieAnimationView.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            lottieAnimationView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            lottieAnimationView.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            lottieAnimationView.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func start(duration: Double = 1, loop: Bool = false, removeOnFinish: Bool = true) {
        addToSuperView()        
        lottieAnimationView.loopMode = loop ? .loop : .playOnce
        lottieAnimationView.play()
        
        if removeOnFinish {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.lottieAnimationView.stop()
                self.lottieAnimationView.removeFromSuperview()
            }
        }
    }
    
    func end() {
        DispatchQueue.main.async {
            self.lottieAnimationView.stop()
            self.lottieAnimationView.removeFromSuperview()
        }
    }
}
