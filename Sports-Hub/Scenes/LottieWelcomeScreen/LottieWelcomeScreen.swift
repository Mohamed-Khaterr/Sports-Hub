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
            
            var tab_VC = TabBarController()
            
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.pushViewController(tab_VC, animated: true)

            
            print("done")
        })
      }

        // Do any additional setup after loading the view.


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
