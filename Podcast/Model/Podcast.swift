//
//  Podcast.swift
//  Podcast
//
//  Created by MARC on 5/5/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import Foundation

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

