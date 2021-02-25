//
//  TableViewModelType.swift
//  MovieApp
//
//  Created by shizo on 10.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation



protocol TableViewViewModelType {
    func numberOfRows() -> Int
    var movies: [ResultsOfMovies] { get }
    func cellViewModel(forIndexPath IndexPath: IndexPath) -> TableViewCellViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func viewModelForSelectedRow() -> DetailViewModelType?
    func fetchMovies(_ url: String, completion: @escaping() -> ())
}
