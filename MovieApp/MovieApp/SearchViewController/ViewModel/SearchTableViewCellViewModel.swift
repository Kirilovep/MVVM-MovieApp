//
//  SearchTableViewCellViewModel.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class SearchTableViewCellViewModel: SearchTableViewCellViewModelType {
    
    private var movies: ResultsOfMovies
    
    var posterPath: String {
        return movies.posterPath ?? " "
    }
    
    var id: Int {
        return movies.id ?? 1
    }
    
    var backdropPath: String {
        return movies.backdropPath ?? " "
    }
    
    var originalLanguage: String {
        return movies.originalLanguage ?? " "
    }
    
    var originalTitle: String {
        return movies.originalTitle ?? " "
    }
    
    var title: String {
        return movies.title ?? " "
    }
    
    var voteAverage: Double {
        return movies.voteAverage ?? 1
    }
    
    var overview: String {
        return movies.overview ?? " "
    }
    
    var releaseDate: String {
        return movies.releaseDate ?? " "
    }
    
    init(movies: ResultsOfMovies) {
        self.movies = movies
    }
}
