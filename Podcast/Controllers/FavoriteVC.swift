//
//  ViewController.swift
//  Podcast
//
//  Created by MARC on 5/5/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {

   override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

