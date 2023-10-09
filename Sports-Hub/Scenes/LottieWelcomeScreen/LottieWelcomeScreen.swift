//
//  LottieWelcomeScreen.swift
//  Sports-Hub
//
//  Created by Admin on 07/10/2023.
//

import UIKit
import Lottie

import Foundation

class LottieWelcomeScreen: UIViewController {
    
    // Completion Handler called when animation time is finish
    public var didFinishAnimation: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LottieAnimationView(name: "LottieAnimation")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leftAnchor.constraint(equalTo: view.leftAnchor),
            animationView.rightAnchor.constraint(equalTo: view.rightAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        animationView.loopMode = .loop
        animationView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.didFinishAnimation?()
        })
    }
    
    deinit {
        print("LottieWelcomeScreen removed from memory (deinitialized)")
    }

}
