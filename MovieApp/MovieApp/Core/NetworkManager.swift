//
//  NetworkManager.swift
//  MovieApp
//
//  Created by shizo663 on 18.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func fetchData<T: Codable>(url: URL,_ responce: @escaping (T?) -> Void)
    func fetchData<T: Codable>(url: URL,_ responce: @escaping (T?, T?) -> Void)
}

class NetworkManager: DataFetcher {
    
    let network: NetworkingService?
    
    init(network: NetworkingService? = NetworkService()) {
        self.network = network
    }
    
    func fetchData<T: Codable>(url: URL,_ responce: @escaping (T?) -> Void) {
        network?.request(url: url) { (data, error) in
            if let error = error {
                print(error)
                responce(nil)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let objects = try? decoder.decode(T.self, from: data)
                responce(objects)
            }
        }
    }
    
    
    func fetchData<T: Codable>(url: URL,_ responce: @escaping (T?, T?) -> Void) {
        network?.request(url: url, completion: { (data, error) in
            if let error = error {
                print(error)
                responce(nil, nil)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let objects = try? decoder.decode(T.self, from: data)
                responce(objects,objects)
            }
        })
    }
}
