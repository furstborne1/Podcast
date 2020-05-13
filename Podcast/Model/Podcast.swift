//
//  Podcast.swift
//  Podcast
//
//  Created by MARC on 5/5/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import Foundation
import FeedKit

struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var feedUrl: String?
    var trackCount: Int?
}

struct SearchResult: Decodable {
    var resultCount: Int
    var results: [Podcast]
}

struct Episode {
    let title: String?
    let pubDate: Date?
    let description: String?
    let streamURL: String?
    var imageURL: String?
    var author: String?
    
    init(episode: RSSFeedItem){
        self.title = episode.title ?? ""
        self.pubDate = episode.pubDate ?? Date()
        self.description = episode.iTunes?.iTunesSubtitle ??  episode.description ?? ""
        self.imageURL = episode.iTunes?.iTunesImage?.attributes?.href ?? ""
        self.author = episode.iTunes?.iTunesAuthor
        self.streamURL = episode.enclosure?.attributes?.url ?? ""
    }
}

