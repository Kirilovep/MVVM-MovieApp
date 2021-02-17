//
//  FavoritesViewModel.swift
//  MovieApp
//
//  Created by shizo663 on 17.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FavoritesViewModel: FavoritesViewModelType {
    
    
    
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var detailMovies: [MovieCoreData] = []
    
    func getData() {
        do {
            detailMovies = try context.fetch(MovieCoreData.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    func numberOfRows() -> Int {
        return detailMovies.count
    }
    
    func cellFavoritesViewModel(forIndexPath IndexPath: IndexPath) -> FavoritesCellViewModelType? {
        let loadedMovies = detailMovies[IndexPath.row]
        return FavoritesCellViewModel(favorites: loadedMovies)
    }
    
    //
}
