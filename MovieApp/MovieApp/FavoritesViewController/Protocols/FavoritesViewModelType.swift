//
//  FavoritesViewModelType.swift
//  MovieApp
//
//  Created by shizo663 on 17.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

protocol FavoritesViewModelType {
    //
    var detailMovies: [MovieCoreData] { get set }
    func getData()
    func numberOfRows() -> Int
    func cellFavoritesViewModel(forIndexPath IndexPath: IndexPath) -> FavoritesCellViewModelType?
}
