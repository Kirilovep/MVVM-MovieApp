//
//  NetworkManager.swift
//  MovieApp
//
//  Created by shizo663 on 18.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    
    func fetchPeople(_ query: String, _ completionHandler: @escaping ([ResultsSearch]) -> Void) {
        let urlSearch = "\(Urls.searchPeople.rawValue)\(Urls.api.rawValue)\(Urls.languageSearch.rawValue)\(Urls.search.rawValue)\(query) \(Urls.firstPage.rawValue))"
        let stringUrl = urlSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? " "
        
        if let url = URL(string: stringUrl){
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try? decoder.decode(PeopleSearchModel.self, from: responceData)
                        completionHandler(movies?.results ?? [] )
                    }
                }
            }.resume()
        }
    }
    
    func fetchMovie(_ query: String, _ completionHandler: @escaping ([ResultsOfMovies]) -> Void) {
        if let url = URL(string: Urls.baseSearchUrsl.rawValue + Urls.api.rawValue + Urls.languageSearch.rawValue + Urls.search.rawValue + query + Urls.firstPage.rawValue){
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
                        completionHandler(movies?.results ?? [])
                    }
                }
            }.resume()
        }
    }
    
    
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
    
    func fetchPeople(_ personId: Int, _ completionHandler: @escaping (People?) -> Void) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try? decoder.decode(People.self, from: responceData)
                        
                        completionHandler(movies)
                    }
                }
            }.resume()
        }
    }
    
    func fetchPersonImages(_ personId: Int, _ completionHandler: @escaping ([Profile]) -> Void) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.images.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue))" ) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try? decoder.decode(ImageProfile.self, from: responceData)
                        
                        completionHandler(movies?.profiles ?? [])
                    }
                }
            }.resume()
        }
    }
    
    func fetchMoviesForPeople(_ personId: Int, _ completionHandler: @escaping ([PersonMovie], [PersonMovie]) -> Void) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.movieCredits.rawValue)\(Urls.api.rawValue)" ) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movies = try? decoder.decode(MoviesForPeople.self, from: responceData)
                        
                        completionHandler(movies?.cast ?? [], movies?.crew ?? [])
                        
                        
                    }
                }
            }.resume()
        }
    }
    
    
    
}
