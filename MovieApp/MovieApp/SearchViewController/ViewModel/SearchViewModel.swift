//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class SearchViewModel: SearchViewModelType {
   
    var selectedIndexPath: IndexPath?
    var searchResultsPeople: [ResultsSearch] = []
    var searchResultsMovies: [ResultsOfMovies] = []
    var quarySearch: String = ""

    
    func numberOfMoviesRows() -> Int {
        return searchResultsMovies.count
    }
    func numberOfPeopleRows() -> Int {
        return searchResultsPeople.count
    }
    func fetchMovies(completion: @escaping () -> ()) {
        NetworkDataFetcher.shared.fetchMovie(quarySearch) { [weak self] (movies) in
            self?.searchResultsMovies = movies?.results ?? []
            completion()
        }
    }
    
    func fetchPeople(completion: @escaping () -> ()) {
        NetworkDataFetcher.shared.fetchPeople(quarySearch) { [weak self](people) in
            self?.searchResultsPeople = people?.results ?? []
            completion()
            
        }
    }
    
    func cellMoviesViewModel(forIndexPath IndexPath: IndexPath) -> SearchTableViewCellViewModelType? {
        let loadedMovies = searchResultsMovies[IndexPath.row]
        return SearchTableViewCellViewModel(movies: loadedMovies)
    }
    
    func cellPeopleViewModel(forIndexPath IndexPath: IndexPath) -> PeopleSearchTableViewCellViewModelType? {
        let loadedPeople = searchResultsPeople[IndexPath.row]
        return PeopleTableViewCellViewModel(people: loadedPeople)
    }
    
    func idForMovieSelectedRow() -> DetailViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil}
        return DetailViewModel(id: searchResultsMovies[selectedIndexPath.row].id)
    }
    
    func idForCrewPeopleSelectedRow() -> (CrewViewModel?) {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return CrewViewModel(idForCrew: searchResultsPeople[selectedIndexPath.row].id)
    }
    
    func idForCastPeopleSelectedRow() -> (CastViewModel?) {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return CastViewModel(idForCast: searchResultsPeople[selectedIndexPath.row].id)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    //
}
