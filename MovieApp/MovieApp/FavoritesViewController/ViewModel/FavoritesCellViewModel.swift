//
//  FavoritesCellViewModel.swift
//  MovieApp
//
//  Created by shizo663 on 17.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class FavoritesCellViewModel: FavoritesCellViewModelType {
    
    private var favorites: MovieCoreData
    
    var id: Int64 {
        return favorites.id
    }
    
    var department: String {
        return favorites.department ?? " "
    }
    
    var image: String {
        return favorites.image ?? " "
    }
    
    var overview: String {
        return favorites.overview ?? " "
    }
    
    var releaseDate: String {
        return favorites.releaseDate ?? " "
    }
    
    var title: String {
        return favorites.title ?? " "
    }
    
    var voteAverage: Double {
        return favorites.voteAverage 
    }
    
    //
    init(favorites: MovieCoreData) {
        self.favorites = favorites
    }
}
