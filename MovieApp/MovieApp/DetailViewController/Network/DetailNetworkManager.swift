//
//  DetailNetworkManager.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class DetailNetworkManager: DetailNetworkManagerType {
    func fetchCast(_ movieId: Int, _ completionHandler: @escaping ([Cast]) -> Void) {
        if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.credits.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try? decoder.decode(CastList.self, from: responceData)
                        completionHandler(movies?.cast ?? [])
                        
                    }
                }
            }.resume()
        }
    }
    
    func fetchCrew(_ movieId: Int, _ completionHandler: @escaping ([Crew]) -> Void) {
        if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.credits.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try? decoder.decode(CastList.self, from: responceData)
                        completionHandler(movies?.crew ?? [])
                        
                    }
                }
            }.resume()
        }
    }
    
    func fetchVideos(_ movieId: Int, _ completionHandler: @escaping ([Video]) -> Void) {
        if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.videos.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try? decoder.decode(VideosResponse.self, from: responceData)
                        completionHandler(movies?.results ?? [])
                        
                    }
                }
            }.resume()
        }
    }
    
    
    func fetchDetailMovie(_ movieId: Int, _ completionHandler: @escaping (DetailList?) -> Void ) {
        if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try? decoder.decode(DetailList.self, from: responceData)
                        completionHandler(movies)
                    }
                }
            }.resume()
        }
    }
    
    
    
    //
}
