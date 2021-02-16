//
//  Network.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation
final class NetworkManager {
    //
    
    func searchMovie(_ query: String, _ completionHandler: @escaping ([ResultsOfMovies]) -> Void ) {
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
    
    func searchPeople(_ query: String, _ completionHandler: @escaping ([ResultsSearch]) -> Void ) {
        
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
}




