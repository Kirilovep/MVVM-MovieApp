//
//  ViewModel.swift
//  MovieApp
//
//  Created by shizo on 10.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


class ViewModel: TableViewViewModelType {
   
    
    
    private var selectedIndexPath: IndexPath?

    private var networkManager = MainNetworkManager()
    
    var movies: [ResultsOfMovies] = []
    
    func numberOfRows() -> Int {
        return movies.count
    }

    func cellViewModel(forIndexPath IndexPath: IndexPath) -> TableViewCellViewModelType? {
        let loadedMovies = movies[IndexPath.row]
        return TableViewCellViewModel(movies: loadedMovies)
        
    }
    
    func fetchMovies(_ url: String, completion: @escaping() -> ()) {
        networkManager.fetchMovies(url, 1) { [ weak self] (movies) in
            self?.movies = movies
            completion()
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
