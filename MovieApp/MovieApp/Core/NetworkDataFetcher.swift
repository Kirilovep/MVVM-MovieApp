//
//  NetworkDataFetcher.swift
//  MovieApp
//
//  Created by shizo663 on 25.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    
    static let shared = NetworkDataFetcher()
    
    var networking: DataFetcher?
    
    private init(networking: NetworkManager = NetworkManager()) {
        self.networking = networking
    }
    
    
    func fetchMovies(_ url: String,_ numberOfPage:Int,_ completionHandler: @escaping (MovieList?) -> Void ) {
        if let url = URL(string: Urls.baseUrl.rawValue + url + Urls.api.rawValue + Urls.pages.rawValue + String(numberOfPage)) {
            networking?.fetchData(url: url, completionHandler)
        }
    }
    
    func fetchMovie(_ query: String, _ completionHandler: @escaping (MovieList?) -> Void) {
        if let url = URL(string: Urls.baseSearchUrsl.rawValue + Urls.api.rawValue + Urls.languageSearch.rawValue + Urls.search.rawValue + query + Urls.firstPage.rawValue) {
            networking?.fetchData(url: url, completionHandler)
        }
    }
    
    func fetchPeople(_ query: String, _ completionHandler: @escaping (PeopleSearchModel?) -> Void) {
        let urlSearch = "\(Urls.searchPeople.rawValue)\(Urls.api.rawValue)\(Urls.languageSearch.rawValue)\(Urls.search.rawValue)\(query) \(Urls.firstPage.rawValue))"
        let stringUrl = urlSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? " "
        
        if let url = URL(string: stringUrl) {
            networking?.fetchData(url: url, completionHandler)
        }
    }
    
    func fetchCastOrCrew(_ movieId: Int, _ completionHandler: @escaping (CastList?) -> Void) {
        if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.credits.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
            networking?.fetchData(url: url, completionHandler)
        }
    }
    
    func fetchVideos(_ movieId: Int, _ completionHandler: @escaping (VideosResponse?) -> Void) {
        if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.videos.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
            networking?.fetchData(url: url, completionHandler)
        }
    }
    
    func fetchDetailMovie(_ movieId: Int, _ completionHandler: @escaping (DetailList?) -> Void ) {
        if let url = URL(string: "\(Urls.baseUrl.rawValue)\(movieId)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
            networking?.fetchData(url: url, completionHandler)
        }
    }
    
    func fetchPeople(_ personId: Int, _ completionHandler: @escaping (People?) -> Void) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.api.rawValue)\(Urls.language.rawValue)" ) {
            networking?.fetchData(url: url, completionHandler)
        }
    }
    
    func fetchPersonImages(_ personId: Int, _ completionHandler: @escaping (ImageProfile?) -> Void) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.images.rawValue)\(Urls.api.rawValue)\(Urls.language.rawValue))" ) {
            networking?.fetchData(url: url, completionHandler)
            
        }
    }
    
    func fetchMoviesForPeople(_ personId: Int, _ completionHandler: @escaping (MoviesForPeople?) -> Void) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.movieCredits.rawValue)\(Urls.api.rawValue)" ) {
            networking?.fetchData(url: url, completionHandler)
        }
    }
    
    func fetchMoviesForPeople(_ personId: Int, _ completionHandler: @escaping (MoviesForPeople?, MoviesForPeople?) -> Void) {
        if let url = URL(string: "\(Urls.baseUrlPerson.rawValue)\(personId)\(Urls.movieCredits.rawValue)\(Urls.api.rawValue)" ) {
            networking?.fetchData(url: url, completionHandler)
        }
    }
}
