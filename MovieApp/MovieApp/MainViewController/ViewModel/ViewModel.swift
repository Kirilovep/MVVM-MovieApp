//
//  ViewModel.swift
//  MovieApp
//
//  Created by shizo on 10.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


class ViewModel: TableViewViewModelType {
        

    var totalPages: Int {
        return moviesData?.totalPages ?? 1
    }
    
    var moviesData: MovieList?
    
    var currentPage: Int = 1

    private var selectedIndexPath: IndexPath?
    var movies: [ResultsOfMovies] = []
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func cellViewModel(forIndexPath IndexPath: IndexPath) -> TableViewCellViewModelType? {
        let loadedMovies = movies[IndexPath.row]
        return TableViewCellViewModel(movies: loadedMovies)
        
    }
    
    func fetchMovies(_ url: String, completion: @escaping() -> ()) {
        NetworkDataFetcher.shared.fetchMovies(url, currentPage) { (movies) in
            self.moviesData = movies
            self.movies += movies?.results ?? []
            completion()
        }
    }
    
    func loadMoreMovies(_ url: String,_ indexPath: IndexPath, completion: @escaping() -> ()) {
        if indexPath.row == movies.count - 3 && currentPage <= totalPages {
            currentPage += 1
            NetworkDataFetcher.shared.fetchMovies(url, currentPage) { (movies) in
                self.moviesData = movies
                self.movies += movies?.results ?? []
                completion()
            }
        }
    }
        
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailViewModel(id: movies[selectedIndexPath.row].id)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
}
