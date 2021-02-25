//
//  CastViewModel.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


class CastViewModel: CastViewModelType {

    var idForPerson: Int?
    
    var castAndCrewMovies: [PersonMovie] = []
     
    var crewMovies: [PersonMovie] = []
    
    func tableViewHeigh() -> Int {
        return castAndCrewMovies.count * 100
    }
    
    private var selectedIndexPath: IndexPath?
    
    var images: [Profile] = []
    
    var personInfo: People?
    
    var detailCast: Cast?
    
    init(idForCast: Int?) {
        self.idForPerson = idForCast
    }
    
    init(_ detailCast: Cast) {
        self.detailCast = detailCast
    }
    
    func numberOfRows() -> Int {
        images.count
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
    
    func castCellViewModel(_ indexPath: IndexPath) -> CollectionViewImagesViewModel {
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
    
    
}
