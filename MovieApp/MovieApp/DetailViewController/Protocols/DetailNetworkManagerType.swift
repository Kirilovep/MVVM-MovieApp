//
//  DetailNetworkManager.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol DetailNetworkManagerType {
    func fetchDetailMovie(_ movieId: Int, _ completionHandler: @escaping (DetailList?) -> Void )
    func fetchCast(_ movieId: Int, _ completionHandler: @escaping ([Cast]) -> Void )
    func fetchCrew(_ movieId: Int, _ completionHandler: @escaping ([Crew]) -> Void )
    func fetchVideos(_ movieId: Int, _ completionHandler: @escaping ([Video]) -> Void )
}
