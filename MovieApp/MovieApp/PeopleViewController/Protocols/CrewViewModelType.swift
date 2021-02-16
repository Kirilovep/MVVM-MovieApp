//
//  CrewViewModelType.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol CrewViewModelType {
    
    var idForPerson: Int? { get set }
    var detailCrew: Crew? { get }
    var personInfo: People? { get }
    var images: [Profile] { get }
    var castAndCrewMovies: [PersonMovie] { get }
     
    func tableViewHeigh() -> Int
    func numberOfRows() -> Int
    func numberOfMoviesRows() -> Int
    func fetchPersonInfo(_ id: Int, completion: @escaping() -> ())
    func fetchImages(_ id: Int, completion: @escaping() -> ())
    func fetchMovies(_ id: Int, completion: @escaping() -> ())
    func crewCellViewModel(_ indexPath: IndexPath) -> CollectionViewImagesViewModel
    func moviesCellViewModel(_ indexPath: IndexPath) -> MoviesTableViewCellViewModel
}
