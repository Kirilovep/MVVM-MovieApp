//
//  CastViewModel.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


class CastViewModel: CastViewModelType {
    
    var castAndCrewMovies: [PersonMovie] = []
     
    var crewMovies: [PersonMovie] = []
    
    func tableViewHeigh() -> Int {
        return castAndCrewMovies.count * 100
    }
    
    private var selectedIndexPath: IndexPath?
    
    var images: [Profile] = []
    
    var personInfo: People?
    
    private var networkManager = PeopleNetworkManager()
 
    var detailCast: Cast?
 
    init(_ detailCast: Cast) {
        self.detailCast = detailCast
    }
    
    func numberOfRows() -> Int {
        images.count
    }
    
    func fetchPersonInfo(_ id: Int, completion: @escaping () -> ()) {
        networkManager.fetchPeople(id) { (personInfo) in
            self.personInfo = personInfo
            completion()
        }
    }
    func fetchImages(_ id: Int, completion: @escaping () -> ()) {
        networkManager.fetchPersonImages(id) { [weak self] (images) in
            self?.images = images
            completion()
        }
    }
    
    func castCellViewModel(_ indexPath: IndexPath) -> CollectionViewImagesViewModel {
        let loadedImages = images[indexPath.row]
        return CollectionViewImagesViewModel(loadedImages)
    }
    
    func fetchMovies(_ id: Int, completion: @escaping () -> ()) {
        networkManager.fetchMoviesForPeople(id) { [weak self] (castMovies, crewMovies) in
            self?.castAndCrewMovies = castMovies
            self?.castAndCrewMovies.append(contentsOf: crewMovies)
            completion()
        }
    }
    
    func numberOfMoviesRows() -> Int {
        return castAndCrewMovies.count
    }
    
    func moviesCellViewModel(_ indexPath: IndexPath) -> MoviesTableViewCellViewModel {
        let loadedMovies = castAndCrewMovies[indexPath.row]
        return MoviesTableViewCellViewModel(movies: loadedMovies)
    }
    
    func idForSelectedRow() -> DetailViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil}
        return DetailViewModel(id: castAndCrewMovies[selectedIndexPath.row].id)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
//    func viewModelForSelectedRow() -> DetailViewModelType? {
//        guard let selectedIndexPath = selectedIndexPath else { return nil }
//        return DetailViewModel(movies: movie[selectedIndexPath.row])
//    }
    
}
