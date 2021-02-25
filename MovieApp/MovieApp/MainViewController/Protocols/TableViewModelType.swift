//
//  TableViewModelType.swift
//  MovieApp
//
//  Created by shizo on 10.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation



protocol TableViewViewModelType {
    var totalPages: Int { get }
    var currentPage: Int { get set }
    var moviesData: MovieList? { get }
    var movies: [ResultsOfMovies] { get set }
    func numberOfRows() -> Int
    func loadMoreMovies(_ url: String,_ indexPath: IndexPath, completion: @escaping() -> ())
    func cellViewModel(forIndexPath IndexPath: IndexPath) -> TableViewCellViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func viewModelForSelectedRow() -> DetailViewModelType?
    func fetchMovies(_ url: String, completion: @escaping() -> ())
}
