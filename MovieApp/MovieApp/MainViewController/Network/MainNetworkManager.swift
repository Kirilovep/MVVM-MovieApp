//
//  MainNetworkManager.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class MainNetworkManager: MainNetworkManagerType {
    
    func fetchMovies(_ url: String,_ numberOfPage:Int,_ completionHandler: @escaping ([ResultsOfMovies]) -> Void ) {
        if let url = URL(string: Urls.baseUrl.rawValue + url + Urls.api.rawValue + Urls.pages.rawValue + String(numberOfPage)) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try? decoder.decode(MovieList.self, from: responceData)
                        completionHandler(movies?.results ?? [] )
                    }
                }
            }.resume()
        }
    }
    
    
    
}
