//
//  CastViewModelType.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol CastViewModelType {

    var idForPerson: Int? { get set}
    var detailCast: Cast? { get set }
    var personInfo: People? { get }
    var images: [Profile] { get }
    var castAndCrewMovies: [PersonMovie] { get }

    
    func tableViewHeigh() -> Int
    func numberOfRows() -> Int
    func numberOfMoviesRows() -> Int
    func fetchPersonInfo(_ id: Int, completion: @escaping() -> ())
    func fetchImages(_ id: Int, completion: @escaping() -> ())
    func fetchMovies(_ id: Int, completion: @escaping() -> ())
    func castCellViewModel(_ indexPath: IndexPath) -> CollectionViewImagesViewModel
    func moviesCellViewModel(_ indexPath: IndexPath) -> MoviesTableViewCellViewModel
    func idForSelectedRow() -> DetailViewModel?
    func selectRow(atIndexPath indexPath: IndexPath)
}
