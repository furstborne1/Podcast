//
//  RootViewController.swift
//  Podcast
//
//  Created by MARC on 5/5/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    
    var maximizePlayerView: NSLayoutConstraint!
    var minimizePlayerView: NSLayoutConstraint!
    
    let playerView = PlayerVC.initNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPurple
        viewControllers = [createSearchVC(), createFavoriteVC(), createDownloadVC()]
        setupPlayerView()
        
        
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
    
    func maximizePlayer(episode: Episode?) {
        maximizePlayerView.isActive = true
        maximizePlayerView.constant = 0
        minimizePlayerView.isActive = false
        
        if episode != nil {
            playerView.episode = episode
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            self.playerView.maximizedPlayerStackView.alpha = 1
            self.playerView.miniPLayerView.alpha = 0
            
        })
    }
    
   func minimizePlayer() {
        maximizePlayerView.isActive = false
        minimizePlayerView.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tabBar.transform = .identity
            self.view.layoutIfNeeded()
            self.playerView.maximizedPlayerStackView.alpha = 0
            self.playerView.miniPLayerView.alpha = 1
        })
    }
    
    private func setupPlayerView() {
        playerView.backgroundColor = .systemBackground
        view.insertSubview(playerView, belowSubview: tabBar)
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        maximizePlayerView = playerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximizePlayerView.isActive = true
        
        minimizePlayerView = playerView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    

}
