//
//  NetworkManager.swift
//  Podcast
//
//  Created by MARC on 5/5/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit
import Alamofire
import FeedKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func getPodcasts(for searchText: String, completion: @escaping(Result<SearchResult, Error>) -> Void) {
        
        let parameters = ["term" : searchText, "media": "podcast"]
        
        AF.request(URLString.itunesURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (responseData) in
            if let error = responseData.error {
                print("error during alamofire request \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = responseData.data else { return }
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(SearchResult.self, from: data)
                completion(.success(results))
            } catch let error {
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func getPodcastFeed(podcast: Podcast, completion: @escaping(Result<[Episode], Error>) -> ()) {
        
        var episode = [Episode]()
        
        guard let urlString = podcast.feedUrl else { return }
        
        let httpsURL = urlString.toHTTPS()
        
        guard let url = URL(string: httpsURL) else { return }
        
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            switch result {
                
            case .success(let feed):
                let imageURL = feed.rssFeed?.iTunes?.iTunesImage?.attributes?.href
                feed.rssFeed?.items?.forEach({ (feedItem) in
                    var episodes = Episode.init(episode: feedItem)
                    
                    if episodes.imageURL == nil {
                        episodes.imageURL = imageURL
                    }
                    
                    episode.append(episodes)
                })
                completion(.success(episode))
        
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
        }
    }
}
