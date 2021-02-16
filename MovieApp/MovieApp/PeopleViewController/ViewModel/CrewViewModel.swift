//
//  CrewViewModel.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


class CrewViewModel: CrewViewModelType {
    
    var idForPerson: Int?
    
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
    
    init(idForCrew: Int?) {
        self.idForPerson = idForCrew
    }
    
    func numberOfRows() -> Int {
        return images.count
    }
    
    func fetchPersonInfo(_ id: Int, completion: @escaping () -> ()) {
        networkManager.fetchPeople(idForPerson ?? 1) { (personInfo) in
            self.personInfo = personInfo
            completion()
        }
    }
    
    func fetchImages(_ id: Int, completion: @escaping () -> ()) {
        networkManager.fetchPersonImages(idForPerson ?? 1) { [weak self] (images) in
            self?.images = images
            completion()
        }
    }
    
    func crewCellViewModel(_ indexPath: IndexPath) -> CollectionViewImagesViewModel {
        let loadedImages = images[indexPath.row]
        return CollectionViewImagesViewModel(loadedImages)
    }
    
    func fetchMovies(_ id: Int, completion: @escaping () -> ()) {
        networkManager.fetchMoviesForPeople(idForPerson ?? 1) { [weak self] (castMovies, crewMovies) in
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
