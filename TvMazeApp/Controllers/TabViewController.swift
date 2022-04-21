//
//  TabViewController.swift
//  TvMazeApp
//
//  Created by Jesus Guerra on 20/04/22.
//

import UIKit

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // All Shows Tab
        let allShowsTab = ShowsViewController(with: .all)
        let allShowsNavigationController = UINavigationController(rootViewController: allShowsTab)
        let allShowsBarItem = UITabBarItem(title: "Shows", image: UIImage(systemName: "film"), selectedImage: nil)
        allShowsTab.tabBarItem = allShowsBarItem

        // Favorites Tab
        let favoritesTab = ShowsViewController(with: .favorite)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesTab)
        let favoriteBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), selectedImage: nil)
        favoritesTab.tabBarItem = favoriteBarItem

        setViewControllers([allShowsNavigationController, favoritesNavigationController], animated: true)
    }
}
