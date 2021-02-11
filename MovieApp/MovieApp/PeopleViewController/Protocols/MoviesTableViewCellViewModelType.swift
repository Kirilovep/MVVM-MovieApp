//
//  MoviesTableViewCellModelType.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol MoviesTableViewCellViewModelType: class {
    var job: String? { get }
    var character: String? { get }
    var releaseDate: String? { get }
    var voteAverage: Double? { get }
    var title: String? { get }
    var posterPath: String? { get }
    var id: Int? { get }
}
