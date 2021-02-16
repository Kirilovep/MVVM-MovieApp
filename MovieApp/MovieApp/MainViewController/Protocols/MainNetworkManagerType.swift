//
//  MainNetworkManagerType.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol MainNetworkManagerType {
    
    func fetchMovies(_ url: String,_ numberOfPage:Int,_ completionHandler: @escaping ([ResultsOfMovies]) -> Void )
}
