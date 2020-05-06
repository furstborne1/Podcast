//
//  RootViewController.swift
//  Podcast
//
//  Created by MARC on 5/5/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPurple
        viewControllers = [createSearchVC(), createFavoriteVC(), createDownloadVC()]
        
        
    }
    
   private func createFavoriteVC() -> UINavigationController {
        let favoriteVC        = FavoriteVC()
        favoriteVC.title      = "Favorite"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        return UINavigationController(rootViewController: favoriteVC)
    }
    
   private func createSearchVC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createDownloadVC() -> UINavigationController {
        let downloadVC        = DownloadVC()
        downloadVC.title      = "Downloads"
        downloadVC.tabBarItem.image = images.downloadsImage
        return UINavigationController(rootViewController: downloadVC)
    }
    

}
