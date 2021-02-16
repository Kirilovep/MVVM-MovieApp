//
//  SearchTableViewCellViewModelType.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


protocol SearchTableViewCellViewModelType: class {
    var posterPath: String { get }
    var id: Int { get }
    var backdropPath: String { get }
    var originalLanguage: String { get }
    var originalTitle: String { get }
    var title: String { get }
    var voteAverage: Double { get }
    var overview: String { get }
    var releaseDate: String { get }
}
