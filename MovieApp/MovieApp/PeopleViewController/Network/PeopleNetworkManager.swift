//
//  PeopleNetworkManager.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class PeopleNetworkManager: PeopleNetworkManagerType {
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
    
    //
}
