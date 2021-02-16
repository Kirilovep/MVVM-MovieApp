//
//  CrewViewModel.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


class CrewViewModel: CrewViewModelType {
    
    
    func tableViewHeigh() -> Int {
        return castAndCrewMovies.count * 100
    }
    
   
    var castAndCrewMovies: [PersonMovie] = []
      
    var images: [Profile] = []
  
    var personInfo: People?
    
    private var networkManager = PeopleNetworkManager()
    
    var detailCrew: Crew?
    

    init(_ detailCrew: Crew) {
        self.detailCrew = detailCrew
    }
    
    func numberOfRows() -> Int {
        return images.count
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
    
    func crewCellViewModel(_ indexPath: IndexPath) -> CollectionViewImagesViewModel {
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
    
    func moviesCellViewModel(_ indexPath: IndexPath) -> MoviesTableViewCellViewModel {
        let loadedMovies = castAndCrewMovies[indexPath.row]
        return MoviesTableViewCellViewModel(movies: loadedMovies)
    }
    
    func numberOfMoviesRows() -> Int {
        return castAndCrewMovies.count
    }
    
}
