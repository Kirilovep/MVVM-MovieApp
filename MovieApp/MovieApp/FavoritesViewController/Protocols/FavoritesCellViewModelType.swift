//
//  FavoritesCellViewModelType.swift
//  MovieApp
//
//  Created by shizo663 on 17.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol FavoritesCellViewModelType: class {
    //
    var id: Int64 { get }
    var department: String { get }
    var image: String { get }
    var overview: String { get }
    var releaseDate: String { get }
    var title: String { get }
    var voteAverage: Double { get }
}
