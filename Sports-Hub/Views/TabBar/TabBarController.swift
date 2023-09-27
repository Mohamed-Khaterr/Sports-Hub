//
//  TabBarController.swift
//  Sports-Hub
//
//  Created by Khater on 26/09/2023.
//

import UIKit


class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarApperance()
        setupTabs()
    }
    
    private func setupTabBarApperance() {
        self.tabBar.tintColor = .label
        self.tabBar.unselectedItemTintColor = .systemGray5
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .secondarySystemBackground
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTabs() {
        let sports = UIViewController()
        sports.view.backgroundColor = .white
        let fav = UIViewController()
        fav.view.backgroundColor = .blue
        
        let vcs: [UIViewController] = [
            createNavigationController(withRoot: sports, barTitle: "Sports", barImage: nil),
            createNavigationController(withRoot: fav, barTitle: "Favorites", barImage: nil),
            // Add your View Controller Here (NOTE: if you want viewController inside NavigationController use createNavigationController method)
            // Example: createNavigationController(withRoot: testViewController, barTitle: "Test", barImage: UIImage(systemName: "plus")),
        ]
        
        
        self.setViewControllers(vcs, animated: true)
    }
    
    private func createNavigationController(withRoot vc: UIViewController, barTitle title: String?, barImage image: UIImage?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
