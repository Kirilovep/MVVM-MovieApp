//
//  MoviesTableViewCellViewModel.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class MoviesTableViewCellViewModel: MoviesTableViewCellViewModelType {
    
    private var movies: PersonMovie
    
    var job: String? {
        return movies.job
    }
    
    var character: String? {
        return movies.character
    }
    
    var releaseDate: String? {
        return movies.releaseDate
    }
    
    var voteAverage: Double? {
        return movies.voteAverage
    }
    
    var title: String? {
        return movies.title
    }
    
    var posterPath: String? {
        return movies.posterPath
    }
    
    var id: Int? {
        return movies.id
    }
    
    init(movies: PersonMovie) {
        self.movies = movies
    }
    
    
}
