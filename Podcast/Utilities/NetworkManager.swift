//
//  NetworkManager.swift
//  Podcast
//
//  Created by MARC on 5/5/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit
import Alamofire

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
                print(results)
                completion(.success(results))
            } catch let error {
                print(error)
                completion(.failure(error))
            }
        }
    }
    
}
