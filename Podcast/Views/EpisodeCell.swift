//
//  EpisodeCell.swift
//  Podcast
//
//  Created by MARC on 5/6/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    var episode: Episode! {
        didSet {
            pubDateLabel.text     = episode.pubDate!.getDate()?.uppercased()
            titleLabel.text       = episode.title
            descriptionLabel.text = episode.description?.withoutHtml
            let url = URL(string: episode.imageURL!.toHTTPS())
            DispatchQueue.main.async {
                self.episodeImageView.sd_setImage(with: url)
                self.episodeImageView.layer.cornerRadius = 8
                self.episodeImageView.layer.masksToBounds = true
            }
        }
    }

    @IBOutlet var episodeImageView: UIImageView!
    @IBOutlet var pubDateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
}
