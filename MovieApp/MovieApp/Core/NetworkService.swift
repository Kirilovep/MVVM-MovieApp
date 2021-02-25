//
//  NetworkService.swift
//  MovieApp
//
//  Created by shizo663 on 25.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol NetworkingService {
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: NetworkingService {
    
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                
            }
            if let responce = response {
                
            }
            
            if let data = data {
                completion(data,error)
            }
        }
        task.resume()
        
    }
}
