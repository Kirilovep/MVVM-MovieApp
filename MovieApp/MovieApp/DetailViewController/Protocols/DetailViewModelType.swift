//
//  DetailViewModelType.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol DetailViewModelType {
    
    
    var backdropPath: String? { get }
    var budget: Int? { get }
    var id: Int? { get set }
    var originalLanguage: String? { get }
    var overview: String? { get }
    var posterPath: String? { get }
    var releaseDate: String? { get }
    var runtime: Int? { get }
    var title: String? { get }
    var voteAverage: Double? { get }
    
    var detailCast: [Cast] { get }
    var detailCrew: [Crew] { get }
    var videos: [Video] { get }
    var results: DetailList? { get }
    
    
    func viewModelForCastSelectedRow() -> CastViewModelType?
    func viewModelForCrewSelectedRow() -> CrewViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func numberOfItemsForCast() -> Int
    func numberOfItemsForCrew() -> Int
    func numbersOfItemsForVideos() -> Int
    func fetchDetails(_ id: Int, completion: @escaping() -> ())
    func fetchCast(_ id: Int, completion: @escaping() -> ())
    func fetchCrew(_ id : Int, completion: @escaping() ->())
    func fetchVideos(_ id: Int, completion: @escaping() ->())
    func castCellViewModel(_ indexPath: IndexPath) -> CollectionViewCastCellViewModel
    func crewCellViewModel(_ IndexPath: IndexPath) -> CollectionViewCrewCellViewModel
    func videosCellViewModel(_ IndexPath: IndexPath) -> CollectionViewVideoCellViewModel
}


