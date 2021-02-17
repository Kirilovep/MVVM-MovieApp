//
//  SearchViewModelType.swift
//  MovieApp
//
//  Created by shizo663 on 16.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol SearchViewModelType {
    
    
    var quarySearch: String { get set }
    var searchResultsPeople: [ResultsSearch] { get set }
    var searchResultsMovies: [ResultsOfMovies] { get set }
    func fetchMovies(completion: @escaping() -> ())
    func fetchPeople(completion: @escaping() -> ())
    func numberOfMoviesRows() -> Int
    func numberOfPeopleRows() -> Int
    func cellMoviesViewModel(forIndexPath IndexPath: IndexPath) -> SearchTableViewCellViewModelType?
    func cellPeopleViewModel(forIndexPath IndexPath: IndexPath) -> PeopleSearchTableViewCellViewModelType?
    func idForMovieSelectedRow() -> DetailViewModel?
    func idForCrewPeopleSelectedRow() -> (CrewViewModel?)
    func idForCastPeopleSelectedRow() -> (CastViewModel?)
    func selectRow(atIndexPath indexPath: IndexPath)
}
