//
//  DetailViewModelType.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class DetailViewModel: DetailViewModelType {
    var id: Int?
    
    var results: DetailList?
    private var movies: ResultsOfMovies?
    private var selectedIndexPath: IndexPath?
   
    var backdropPath: String? {
        return results?.backdropPath
    }
    
    var budget: Int? {
        return results?.budget
    }

    var originalLanguage: String? {
        return results?.originalLanguage
    }
    
    var overview: String? {
        return results?.overview
    }
    
    var posterPath: String? {
        return results?.posterPath
    }
    
    var releaseDate: String? {
        return results?.releaseDate
    }
    
    var runtime: Int? {
        return results?.runtime
    }
    
    var title: String? {
        return results?.title
    }
    
    var voteAverage: Double? {
        return results?.voteAverage
    }
    
    var detailCast: [Cast] = []
    
    var detailCrew: [Crew] = []
    
    var videos: [Video] = []
        
    init(id: Int?) {
        self.id = id
    }
    
    func numberOfItemsForCast() -> Int {
        return detailCast.count
    }
    
    func numberOfItemsForCrew() -> Int {
        return detailCrew.count
    }
    
    func numbersOfItemsForVideos() -> Int {
        return videos.count
    }
    
    func fetchDetails(_ id: Int, completion: @escaping () -> ()) {
        NetworkManager.shared.fetchDetailMovie(id) { [weak self] (details) in
            guard let details = details else { return }
            self?.results = details
            completion()
        }
    }
    
    func fetchCast(_ id: Int, completion: @escaping () -> ()) {
        NetworkManager.shared.fetchCast(id) { [weak self] (cast) in
            self?.detailCast = cast
            completion()
        }
    }
    
    func fetchCrew(_ id: Int, completion: @escaping () -> ()) {
        NetworkManager.shared.fetchCrew(id) { [weak self] (crew) in
            self?.detailCrew = crew
            completion()
        }
    }
    
    func fetchVideos(_ id: Int, completion: @escaping () -> ()) {
        NetworkManager.shared.fetchVideos(id) { [weak self] (videos) in
            self?.videos = videos
            completion()
        }
    }
    
    func videosCellViewModel(_ IndexPath: IndexPath) -> CollectionViewVideoCellViewModel {
        let loadedVideos = videos[IndexPath.row]
        return CollectionViewVideoCellViewModel(videos: loadedVideos)
    }
    
    
    func castCellViewModel(_ indexPath: IndexPath) -> CollectionViewCastCellViewModel {
        let loadedCast = detailCast[indexPath.row]
        return CollectionViewCastCellViewModel(cast: loadedCast)
    }
    
    func crewCellViewModel(_ IndexPath: IndexPath) -> CollectionViewCrewCellViewModel {
        let loadedCrew = detailCrew[IndexPath.row]
        return CollectionViewCrewCellViewModel(crew: loadedCrew)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func idForCrewPeopleSelectedRow() -> (CrewViewModel?) {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return CrewViewModel(idForCrew: detailCrew[selectedIndexPath.row].id)
    }
    
    func idForCastPeopleSelectedRow() -> (CastViewModel?) {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return CastViewModel(idForCast: detailCast[selectedIndexPath.row].id)
    }
    
}


