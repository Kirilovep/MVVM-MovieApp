//
//  SearchNetworkManager.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class SearchNetworkManager: SearchNetworkManagerType {
    
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
    
    //
}
