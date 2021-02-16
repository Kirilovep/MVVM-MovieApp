//
//  SearchNetworkManager.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol SearchNetworkManagerType {
    func fetchMovie(_ query: String, _ completionHandler: @escaping ([ResultsOfMovies]) -> Void )
    func fetchPeople(_ query: String, _ completionHandler: @escaping ([ResultsSearch]) -> Void )
}
