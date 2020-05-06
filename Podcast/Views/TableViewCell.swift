//
//  TableViewCell.swift
//  Podcast
//
//  Created by MARC on 5/6/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit
import SDWebImage


class TableViewCell: UITableViewCell {

    @IBOutlet var podcastImageView: UIImageView!
    @IBOutlet var trackName: UILabel!
    @IBOutlet var artistName: UILabel!
    @IBOutlet var count: UILabel!
    
    var podcast: Podcast! {
        didSet {
            trackName.text = podcast.trackName
            artistName.text = podcast.artistName
            count.text = "\(podcast.trackCount ?? 0) Episodes"
            if let imageURL = podcast.artworkUrl600 {
                let url = URL(string: imageURL)
                podcastImageView.sd_setImage(with: url, completed: nil)
                podcastImageView.layer.cornerRadius = 8
                podcastImageView.layer.masksToBounds = true
            }
        }
    }
    
}
