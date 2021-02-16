//
//  PeopleNetworkManagerType.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol PeopleNetworkManagerType {
    func fetchPeople(_ personId: Int, _ completionHandler: @escaping (People?) -> Void )
    func fetchPersonImages(_ personId: Int, _ completionHandler: @escaping ([Profile]) -> Void )
    func fetchMoviesForPeople(_ personId: Int, _ completionHandler: @escaping ([PersonMovie], [PersonMovie] ) -> Void )
}
