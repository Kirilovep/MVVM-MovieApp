//
//  CollectionViewCellViewModel.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation


class CollectionViewCastCellViewModel: CollectionViewCastCellViewModelType {
    
    private var cast: Cast
    
    var castId: Int? {
        return cast.castId
    }
    
    var character: String? {
        return cast.character
    }
    
    var creditId: String? {
        return cast.creditId
    }
    
    var gender: Int? {
        return cast.gender
    }
    
    var id: Int? {
        return cast.id
    }
    
    var name: String? {
        return cast.name
    }
    
    var order: Int? {
        return cast.order
    }
    
    var profilePath: String? {
        return cast.profilePath
    }

    init(cast: Cast) {
        self.cast = cast
    }
    
    
    
    
}
