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
        NetworkDataFetcher.shared.fetchPeople(idForPerson ?? 1) { (personInfo) in
            self.personInfo = personInfo
            completion()
        }
    }
    
    func fetchImages(_ id: Int, completion: @escaping () -> ()) {
        NetworkDataFetcher.shared.fetchPersonImages(idForPerson ?? 1) { [weak self] (images) in
            self?.images = images?.profiles ?? []
            completion()
        }
    }
    
    func crewCellViewModel(_ indexPath: IndexPath) -> CollectionViewImagesViewModel {
        let loadedImages = images[indexPath.row]
        return CollectionViewImagesViewModel(loadedImages)
    }
    
    
    func fetchMovies(_ id: Int, completion: @escaping () -> ()) {
        NetworkDataFetcher.shared.fetchMoviesForPeople(idForPerson ?? 1) { [weak self] (castMovies, crewMovies) in
            self?.castAndCrewMovies = castMovies?.cast ?? []
            self?.castAndCrewMovies.append(contentsOf: crewMovies?.crew ?? [])
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
