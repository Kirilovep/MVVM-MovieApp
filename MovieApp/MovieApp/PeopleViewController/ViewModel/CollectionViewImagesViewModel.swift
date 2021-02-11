//
//  CollectionViewImagesViewModel.swift
//  MovieApp
//
//  Created by shizo on 11.02.2021.
//  Copyright © 2021 Kyrylov. All rights reserved.
//

import Foundation

class CollectionViewImagesViewModel: CollectionViewImagesCellViewModelType {
    
    private var images: Profile
    
    var imagePath: String {
        return images.filePath ?? " "
    }
    
    init(_ images: Profile) {
        self.images = images
    }
    
    
}
